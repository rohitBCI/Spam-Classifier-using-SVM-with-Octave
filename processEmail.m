% preprocesses the body of an email and returns a list of indices of the words contained in the email. 
function word_indices = processEmail(email_contents)

% Load Vocabulary
vocabList = getVocabList();

word_indices = [];

% Lower case
email_contents = lower(email_contents);

% Strip all HTML
email_contents = regexprep(email_contents, '<[^<>]+>', ' ');

% Handle Numbers
email_contents = regexprep(email_contents, '[0-9]+', 'number');

% Handle URLS
email_contents = regexprep(email_contents, ...
                           '(http|https)://[^\s]*', 'httpaddr');

% Handle Email Addresses
email_contents = regexprep(email_contents, '[^\s]+@[^\s]+', 'emailaddr');

% Handle $ sign
email_contents = regexprep(email_contents, '[$]+', 'dollar');


% Output the email to screen as well
fprintf('\n==== Processed Email ====\n\n');

% Process file
l = 0;

while ~isempty(email_contents)

    % Tokenize and also get rid of any punctuation
    [str, email_contents] = ...
       strtok(email_contents, ...
              [' @$/#.-:&*+=[]?!(){},''">_<;%' char(10) char(13)]);
   
    % Remove any non alphanumeric characters
    str = regexprep(str, '[^a-zA-Z0-9]', '');

    % Stem the word 
    try str = porterStemmer(strtrim(str)); 
    catch str = ''; continue;
    end;

    % Skip the word if it is too short
    if length(str) < 1
       continue;
    end

    n1 = size(vocabList,1);
    for i = 1:n1
        str1 = str;
        str2 = vocabList(i);
        if strcmp(str1, str2)==1
            word_indices = [word_indices; i];
        end
    end

    % Print to screen, ensuring that the output lines are not too long
    if (l + length(str) + 1) > 78
        fprintf('\n');
        l = 0;
    end
    fprintf('%s ', str);
    l = l + length(str) + 1;

end

% Print footer
fprintf('\n\n=========================\n');

end
