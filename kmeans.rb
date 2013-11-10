require 'pry'
#require 'gruff'
small_map = 
[
  [" "," ","█","█"," "],
  [" "," "," "," ","█"],
  [" ","█"," ","█","█"],
  ["█","█"," "," "," "],
  ["█","█"," ","█"," "]
]
map = 
[
  ["-","-","-","-","-"],
  ["-","-","-","-","-"],
  ["-","-","-","-","-"],
  ["-","-","-","-","-"],
  ["-","-","-","-","-"]
]
# Coordinates
#        [0,0][1,0][2,0]-->
# [0,0]  [" "," ","█","█"," "],
# [0,1]  [" "," "," "," ","█"],
# [0,2]  [" ","█"," ","█","█"],
#   |    ["█","█"," "," "," "],
#   V    ["█","█"," ","█"," "]

# input:
#   E = e1,e2,e3 ... set of entities to be clustered
#   k = number of clusters
#   MaxIters = limit of iterations
# output:
#   C = c1,c2,c3,c4 .. set of cluster centroids
#   L = set of cluster labels of E

# foreach c 
#   randomly assign e to a cluster
# end

# foreach e
#   l(e) <-- argmin distance to each c
# end

# changed false
# iter 0
# do 
#   foreach e do
#     update cluster(ci)
#   end

#   for each e do
#     minDist <-- argminDistance(ei,cj) j for 1..k
#     if minDist != l(e) then
#       l(ei) <- minDist
#       changed <- true
#     end
#   end
#   iter += 1

# until changed == true and iter <= MaxIters
class KMeans
  attr_accessor :map, :points, :assignments, :centers
  def initialize
    #@map = map
  end
  def for_print
    self.map.each do |row|
      row.each do |box|
        print box
      end
      puts
    end
  end

  def mappoints(points)
    points.each do |point|
      x = point[0]
      y = point[1]
      self.map[x][y] = "o"
    end
    for_print
  end

  def calculate_new_centers(k)
    self.centers.map do |group|
      group_arr = assignments.select do |assignment|
        assignment[1] == group
      end
      sum_x = 0
      sum_y = 0
      group_arr.each do |point|
        sum_x += point[0][0]
        sum_y += point[0][1]
      end
      if group_arr.count != 0
        mean_x = sum_x/group_arr.count
        mean_y = sum_y/group_arr.count
      end
      [mean_x, mean_y]
    end
  end

  def distance(center, point)
    # (center[0] - point[0])**2 + (center[1] - point[1])**2
    sum = 0
    (0..center.count-1).each do |d|
      sum += (center[d] - point[d])**2
    end
    sum
  end

  def reassign_groups(centers)
   #old_assignments = assignments
   #p "old_assignments #{assignments}"
    assignments.each do |assignment|
      point = assignment[0]
      new_group = centers.min_by do |center|
        distance(center,point)
      end
      assignment[1] = new_group
    end
   #old_assignments.sort != assignments.sort #changed?
  end


  def cluster(k,points,max_iters)
    self.assignments = []

    self.centers = [[1,1],[4,4]]
    points.each do |point|
      self.assignments << [point, centers[rand(0..centers.count-1)]]
    end
    p assignments

    changed = false
    iter = 0
    #5.times do
    begin 
      self.centers = calculate_new_centers(k)
      reassign_groups(centers)
      iter += 1
    end  while iter <= max_iters

  
  groups = self.centers.map do |center|
    self.assignments.select {|assignment| assignment[1] == center}
  end
  hard_group = groups.collect {|group| group.collect{|x| x[0] }   }
  groups = groups.group_by{|x| x[1]}
  better_group = {}
  groups.each{|k,v| better_group[k[1]] = v[0].flatten(1).uniq;}

  #p "These are the groups"
  #p groups
  binding.pry

  end
end

 algo = KMeans.new
 points = [[4,2],[4,3],[4,4],[1,2],[1,3],[1,1],[3,2],[3,4],[4,4],[0,0],[0,1]]
# algo.cluster(2,points,6)
# algo.map = map
# points = [[0,0],[1,0],[4,4],[4,3],[1,1],[3,4]]
# algo.mappoints(points)
# # algo.cluster(3,points, 5)

# #algo.calculate_new_centers(3)
 algo.cluster(2,points, 10)
 p algo.centers
 p algo.assignments
# p algo.assignments