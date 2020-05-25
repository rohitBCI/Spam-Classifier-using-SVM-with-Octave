% takes in a word_indices vector and produces a feature vector from the word indices. 
function x = emailFeatures(word_indices)

n = 1899;	% Total number of words in the dictionary
x = zeros(n, 1);

n2 = size(word_indices,1);
for i =1:n2
	t = word_indices(i);
	x(t) = 1;
end

end
