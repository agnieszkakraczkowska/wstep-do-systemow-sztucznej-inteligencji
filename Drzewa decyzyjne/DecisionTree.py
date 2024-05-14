import numpy as np
from collections import Counter


class Node:
    def __init__(self, feature=None, threshold=None, left=None, right=None, *, value=None):
        self.feature = feature  # cecha
        self.threshold = threshold  # próg podziału
        self.left = left  # lewy podwęzeł
        self.right = right  # prawy podwęzeł
        self.value = value  # wartość węzła

    def is_leaf_node(self):
        return self.value is not None


class DecisionTree:
    def __init__(self, min_samples_split=2, max_depth=100, n_features=None):
        self.min_samples_split = min_samples_split  # min liczba próbek do podziału
        self.max_depth = max_depth  # max głębokość drzewa
        self.n_features = n_features  # liczba cech do podziału
        self.root = None  # korzeń drzewa

    def fit(self, X, y):
        # jeśli liczba cech do podziału jest podana
        if self.n_features is not None:
            # porównujemy ją z liczbą cech w danych
            self.n_features = min(self.n_features, X.shape[1])  # metoda shape zwraca liczbę wierszy i liczbę kolumn
        else:
            # jeśli nie jest podana to ustawiamy ją na liczbę cech w danych
            self.n_features = X.shape[1]
        self.root = self._grow_tree(X, y)

    def _grow_tree(self, X, y, depth=0):
        num_of_samples, num_of_features = X.shape
        num_of_labels = len(np.unique(y))
        if num_of_labels == 1 or self.max_depth <= depth or num_of_samples < self.min_samples_split:
            counter = Counter(y)
            most_common_val = counter.most_common(1)[0][0]
            return Node(value=most_common_val)

        best_feature, best_threshold = self._best_split(X, y)
        left_idx, right_idx = self._split(X[:, best_feature], best_threshold)
        left_subtree = self._grow_tree(X[left_idx], y[left_idx], depth + 1)
        right_subtree = self._grow_tree(X[right_idx], y[right_idx], depth + 1)
        return Node(feature=best_feature, threshold=best_threshold, left=left_subtree, right=right_subtree)

    def _best_split(self, X, y):
        best_information_gain = -1
        best_feature = None
        best_threshold = None
        features = np.random.choice(X.shape[1], self.n_features, replace=False)  # wybór losowych cech
        for feature in features:
            X_column = X[:, feature]  # dane odpowiadające cesze
            thresholds = np.unique(X_column)
            for threshold in thresholds:
                information_gain = self._information_gain(y, X_column, threshold)
                if information_gain > best_information_gain:
                    best_information_gain = information_gain
                    best_threshold = threshold
                    best_feature = feature
        return best_feature, best_threshold

    def _information_gain(self, y, feature_values, threshold):  # wzór ze źródła
        parent_entropy = self._entropy(y)
        left_idx, right_idx = self._split(feature_values, threshold)
        weighted_average_left = len(left_idx) / len(y)
        weighted_average_right = len(right_idx) / len(y)
        children_entropy_left = self._entropy(y[left_idx])
        children_entropy_right = self._entropy(y[right_idx])
        information_gain = parent_entropy - (
                (weighted_average_left * children_entropy_left) + (weighted_average_right * children_entropy_right))
        return information_gain

    # podział drzewa na podstawie progu podziału
    def _split(self, X_column, split_threshold):
        left_idx = np.where(X_column < split_threshold)[0]
        right_idx = np.where(X_column >= split_threshold)[0]
        return left_idx, right_idx

    def _entropy(self, y):  # wzór ze źródła (gotowy)
        hist = np.bincount(y)
        ps = hist / len(y)
        return -np.sum([p * np.log(p) for p in ps if p > 0])

    # trawersowanie porządkiem preorder
    def _traverse_tree(self, x, node):
        if node.is_leaf_node():
            return node.value
        if x[
            node.feature] <= node.threshold:
            return self._traverse_tree(x, node.left)
        else:
            return self._traverse_tree(x, node.right)

    def predict(self, X):
        return np.array([self._traverse_tree(x, self.root) for x in X])
