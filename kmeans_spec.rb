require_relative 'spec_helper.rb'
require_relative 'kmeans.rb'


map = [
[" "," ","█"," "," "],
[" "," "," "," ","█"],
[" ","█","█","█","█"],
[" ","♥"," "," "," "],
[" "," "," ","█"," "]
]

describe KMeans do
  let(:new_cluster) { KMeans.new }
  context "#new" do #this test is now irrelevant
    it "instantiates a new map without errors" do   
      new_cluster.map = map
      expect(new_cluster.map).to eq(map)
    end
  end
    
  context "#distance(center,point)" do
    it "gives the euclidean distance of the given point and center" do
      new_cluster.distance([0,0],[-3,-4]).should eq(25)
      new_cluster.distance([5,12],[0,0]).should eq(13**2)
    end
  end

  context "#calculate_new_centers(k)" do
	  it "given the points separated into their respective groups we find the center of these groups" do
     new_cluster.centers = [[4,4],[4,3],[4,2]] # previous centers
	   new_cluster.assignments = [[[4,2],[4,3]], [[4,3],[4,3]],[[4,4],[4,3]], [[1,2],[4,4]],[[1,3],[4,4]],[[1,1],[4,4]],[[3,2],[4,2]]]
     new_cluster.calculate_new_centers(2).sort.should eq([[4,3],[3,2],[1,2]].sort)
	  end
  end

  context "#reassign_groups(centers)" do
    it "it takes several center points and puts the rest of the points into the nearest group" do
	    new_cluster.assignments = [[[4,2],2],[[4,3],1],[[4,4],2],[[1,2],2],[[1,3],1],[[1,1],3],[[3,2],2]]
      correct_assignments = [[[4,2],[4,3]], [[4,3],[4,3]],[[4,4],[4,3]], [[1,2],[0,2]],[[1,3],[0,2]],[[1,1],[0,2]],[[3,2],[4,3]]]
     #p new_cluster.reassign_groups([[1,2],[4,3]])
      new_cluster.reassign_groups([[0,2],[4,3]])
      new_cluster.assignments.sort.should eq(correct_assignments.sort)
     #p new_cluster.reassign_groups([[0,2],[4,3]])
      
    end
  end

  context "#cluster(starting_node, looking_for" do
    it "implements the k-means clustering algorithm, takes the data points and allocates them into k groups of similar elements" do
     #points = [[4,2],[4,3],[4,4],[1,2],[1,3],[1,1],[3,2]]
     #p new_cluster.cluster(2,points,6)
    end
  end
end 

