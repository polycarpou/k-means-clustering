k-means-clustering
==================

Implements the unsupervised machine learning technique of k-means-clustering. This takes in data and separates it into similar groups or clusters


For example:

For inputs like this:
[[4, 2, 1],
 [4, 3, 2],
 [4, 4, 3],
 [1, 2, 4],
 [1, 3, 4],
 [1, 1, 0],
 [3, 2, 1],
 [3, 4, 2],
 [4, 4, 3],
 [0, 0, 4],
 [0, 1, 2]]

We ask the algorithm to create 3 clusters.
It returns 3 centers points
[0, 1, 1], [0, 1, 4], [3, 3, 2]

and groups all of the points in a hash under the nearest center

 [0, 1, 1]=>[[1, 1, 0], [0, 1, 1], [0, 1, 2]],
 [0, 1, 4]=>[[1, 2, 4], [0, 1, 4], [1, 3, 4], [0, 0, 4]],
 [3, 3, 2]=>[[4, 2, 1], [3, 3, 2], [4, 3, 2], [4, 4, 3], [3, 2, 1], [3, 4, 2]]

 If we picture this drawn out in a 3d plane, we can see that the [1, 1, 0], [0, 1, 1], [0, 1, 2] points have a center at [1, 1, 0] and they are all pretty close to each other. Similar logic goes to the rest of the groups.