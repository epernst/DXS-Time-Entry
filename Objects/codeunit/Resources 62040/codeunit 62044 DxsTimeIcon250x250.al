codeunit 62044 DxTimeIcon250x250
{

    trigger OnRun();
    begin
    end;
    
    procedure GetIcon(var TempBlob : Record TempBlob);
    begin
        TempBlob.FromBase64String(IconSource);
    end;
    
    local procedure IconSource() : Text;
    begin
        exit(
            'iVBORw0KGgoAAAANSUhEUgAAAPoAAAD6CAYAAACI7Fo9AAAAB3RJTUUH4QofCAg3LXFDUAAAAAlwSFlzAABOIAAATiABFn2Z3gAAAARnQU1BAACxjwv8YQUAAAjaSURBVHja7ZhBcqNlFAO5GPfjQNwvbKGKgn' +
            'Fi/y099aK3tr4n9UyS376+vn4TkdvgAURE0UVE0UVE0UVE0UVWwAOIiKKf448/f/9ahb79MniANWjZFH0TPMAatGyKvgkeYA1aNkXfBA+wBi2bom+CB1iDlk3RN8EDrEHLpuib4AHWoGVT9E3wAGvQsin6JniA' +
            'NWjZFH0TPMAatGyKvgkeYA1aNkXfBA+wBi2bom+CB1iDlk3RN8EDrEHLpuib4AHWoGVT9E3wAGvQsin6JniANWjZFH0TPMAatGyKvgkeYA1aNkXfBA+wBi2bom+CB1iDlk3RN8EDrEHLpuib4AHWoGVT9E3wAG' +
            'vQsin6JniANWjZFH0TPMAatGyKvgkeYA1aNkXfBA+wBi2bom+CB1iDlk3RN8EDrEHLpuib4AHWoGVT9E3wAGvQsin6JniANWjZFH0TPMAatGyKvgkeYA1aNkXfBA+wBi2bom+CB1iDlk3RN8EDrEHLpuib4AHW' +
            'oGVT9E3wAGvQsin6JniANWjZFH0TPMAatGyKvgkeYA1aNkXfBA+wBi2bom+CB1iDlk3RN8EDrEHLpuib4AHWoGVT9E3wAGvQsin6JniANWjZFH0TPMAatGyKvgkeYA1aNkXfBA+wBi2bom+CB1iDlk3RN/nIiO' +
            'lHJUPLpuh5PHGjj4+YPmIatGyKnsHTd3p0wPRxE6BlU/T87utFt3RFXyPlThEDpstIL/4K9O2bOo4U3UEour1m3yrykZfHQcum6B1dzol+bSi0bIre01+U6I6m414J0Ldv60zRiwdE38qeenpS9OIx0fexm65u' +
            'IkSnj9A4LPom9tHVh6KXDo2+wfr92zpQ9JADLt2s9ebtd1f0oEOu3Sz9zpdujYpOPz75qIt387bZd/OoDw+TfpP37EPRy469eDdvmHE7D/3w4encjTdbv5uih+DtPjNWOm8Sih6Gt/vZWOmMyTwqOv3YJrzfrw' +
            '2VztWCohfg/f45VDpLI4ouMoKiiwzwiOj0I0XWUXSRERRdZICPik4/TvpwN4oux2VwN1myK3pIYXQO39TFR0SnH3WdS7e+9JZkFL2QK/e+8IYmFL2M9pu352/lraLTj1mh9fbuJu/2ih5MYwdteS+i6IU09dCU' +
            '9TKKXkhLFy05F3iL6PQj1kj/w2h6vkUUvZRUmX51UPT9FlH0Ql75S2paJvp2q/xIdDr8MkmyJ2URRT/FK3J9squUHPLzriwtkFcFe3df9PfLQ6LToYWT7Tvf62Z4FL2U7wr3k/6UvBtFL+VJ2Yl/WAQUnQ4r75' +
            'HvlS6f+h5RdPmAgP/X56c/X3I2Y3HhfErGd3yue8lD0Ut5l5B/7/YTnykZ/JLodEj5vOxKfh9FL4UWWtG7UPRSaKGVvIv/FJ0OJ12y0/eQ1/ZicSXQYit6F4peDC23W+nhX0WnQ4miy2f3YnFF0IK7lS4UvRhF' +
            'F0UfQNHl26JbYBdKLq9uw0LL8H9z+c4mLLcI+sd295DDq71ZcgG03G4hg5/0ZdHh0EK7gRv9W3gotMT2f6t7iw+EFtfO73XuAIKgZbXvu307ghBoQe35ds+OYbR4O97qGA+wPAj67na70y0eYHEY9I3tda9XPM' +
            'DaOOib0tD3X+0TD7AyEvp2SdBdLHaJB1gYC32rVOheljrEA1weDH2XBuiOVvrDA1wdDn2HNui+rveGB7g2HvrNzSi3oleMiH7jFexK0SPHlJL109/X2s+q3Ir+xlE9PdYnxpyULeEeF8ADpEH9nrggetMNroEH' +
            'SIYeLDFyOr9iK7rCK7qCK7qSv0MAOruyK7qiK7qyK7qS/3T4dG5FV3Qlf2D8dGZlV3QlV3RlV3RFV3RlV/SxsX9n8HReRVd0JX9g9HRWZVd0RVd0ZVd0JVd0RVf0wZG/OnY6J/3+BfAANPQYE8ZOZ6TfvwAegI' +
            'YeYsLQ6YwJN7gOHkDJ+ZHTGRNucB08gJKzI6fzpdzhOngAJWdHTmdLucN18ACKrugJd7gOHkDJuYHTuZJucR08gJIreso9LoMHUHRu3HSmpFtcBw+g5Iqeco/L4AGUnBk2nScBepeKruSKruyKrug/HzWdJQV6' +
            'n4qu5Iqu7Iqu5N8fNJ0jEXqviq7oiq7oiq7krw+azpAKvVtFV3JFV3ZFV3JRdkUXUXQ6gJJLIvSeFV3JRdkVXUTRD4pOj0FuQ+9b0ZVclP2+6HT5sgW9d0WXlwdLZ2iE3vuk6HTprXi/XdnxAErOjJTO0wq9f0' +
            'WXlwdKZ2qE3v+E6HTJrXhPZccDKDk7SjpfK7QPJ0WnS23F+2bcNwE8gEPMGCKdtRHai1Oi02W24p0z76zojg8fH527FdoTRR/Fm/fce150urxWvHvn3SdFp0trxfvfuP+E6HRZrdgDD+2Oog9gFxnQ/lSITpfU' +
            'in1kQXsULTpdTiv2kgntk6Ifw24yoX2KFJ0upRX7yYb2Kkp0uoxW7KkD2q8I0ekSWrGvHmjBFb0YO+uClhwVnT5+K/Rg6Pe3QvfmWIqgx2J/vf05lBJoue2wu0OHUgIttv11d+hgCqA7srv+DvGxOJjsgdjdjf' +
            '7wAA6mYyj21t0dHsDhdAzFzrp7wwM4nJ6x2Flvb3gAh9MzFjvr7Q0P4Hi6BmNXnX3hARxQ32jsqq8vPIAD6huNXfX1hQdwRJ3DWe2otSc8gEPqHc9aR8094QEcUu94ljpq7wkPsD4m+n72s9ERHmB9TPTt7Gaj' +
            'HzzA8qDom9nNTjd4gNVR0Xeyl61u8ACro6JvZCdbveABFodF38ZO9jrBA6yNi74HDX3/1U7wAEvjou+QAt3DYid4gKWB0e9Pge5hsQs8wMrI6HenoeSKfm5k9HtTsQdFPzU0+p2pKLminxkb/b50lFzR68dGv6' +
            'sF76/otYOj39KEkit67ejod7Sh5IpeNzo6fyveXdFrhkdnbkfJFT1+eHTWCyi5osePj855Be+t6LEDpLNdQ8kVPW6AdKaLKLii4zg+79wGHqAZx/ec7HSOdvAAIqLoIqLoIqLoIqLoIiv8BQNjq5lPgFw8AAAA' +
            'AElFTkSuQmCC');
    end;
}

