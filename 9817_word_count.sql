-- use string to array and unnest
with words_clean as (
    select
        -- 1. turn string into an array of words, delimited by space ' '
        -- 2. unest from an array
        -- 3. lower all words
        -- 4. trim punctuation marks
        trim(both '.,' from lower(unnest(string_to_array(contents, ' ')))) as word
    from google_file_store
    where lower(filename) like '%draft%'
)
select
    word,
    count(*) AS occurences
from words_clean
group by 1
order by 2 desc;

-- vectorise words
select 
    word,
    nentry                                       
from
    --returns statistics about each distinct lexeme (word) contained in the tsvector data.
    --The columns returned are:
    ----word text — the value of a lexeme
    ----ndoc integer — number of documents (tsvectors) the word occurred in
    ----nentry integer — total number of occurrences of the word
    ts_stat(
        -- https://medium.com/geekculture/comprehend-tsvector-and-tsquery-in-postgres-for-full-text-search-1fd4323409fc
        -- return a sorted collection of key-value pairs,
        -- where the key represents the lexeme and the values represent the lexeme’s position
        'SELECT to_tsvector(contents) FROM google_file_store WHERE filename
        ILIKE ''draft%'''
    );