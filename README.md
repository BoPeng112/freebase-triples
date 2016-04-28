# freebase-mql

A reflection and review of [Freebase.com](http://www.freebase.com) and the (now deprecated) Metaweb Query Language (MQL). This repo is a response to the increasing attention being given to Facebook's [GraphQL](https://code.facebook.com/posts/1691455094417024), which was released in September 2015. Those who have worked with MQL before would have immediately noticed the similiarities with GraphQL. 


## Freebase

The [Freebase](https://en.wikipedia.org/wiki/Freebase) Wikipedia article provides a good overview of its beginnings at Metaweb Technologies, Inc., its acquisition by Google in 2010, and its eventual shutdown and move to Wikidata. Freebase accepted queries to its vast stores of data through the Metaweb Query Language (MQL).


## Sample MQL Scripts

Some samples of MQL scripts that I wrote are enclosed as txt files in the mql-queries folder. At the time, I queried these MQL scripts against the Freebase API using Python. Due to Python requirements, "None" may need to be replaced with "null" in the MQL queries. 

The [MQL Reference Guide](https://developers.google.com/freebase/mql/ch03#firstquery) presents the following as a first query using MQL.

```
	Query:
	{
	  "type" : "/music/artist",
	  "name" : "The Police",
	  "album" : []
	}

	Response:
	{
	  "type": "/music/artist",
	  "name": "The Police",
	  "album": [
	    "Outlandos d'Amour",
	    "Reggatta de Blanc",
	    "Zenyatta Mondatta",
	    "Ghost in the Machine",
	    "Synchronicity",
	  ]
	}
```

In comparison, the [GraphQL documentation](https://facebook.github.io/react/blog/2015/05/01/graphql-introduction.html) offers the following introductory query:
```
	Query:
	{
	  user(id: 3500401) {
	    id,
	    name,
	    isViewerFriend,
	    profilePicture(size: 50)  {
	      uri,
	      width,
	      height
	    }
	  }
	}

	Response:
	{
	  "user" : {
	    "id": 3500401,
	    "name": "Jing Chen",
	    "isViewerFriend": true,
	    "profilePicture": {
	      "uri": "http://someurl.cdn/pic.jpg",
	      "width": 50,
	      "height": 50
	    }
	  }
	}
```

The syntax has some differences but there are notable similarities in the general nested structure and query format. The query request essentially lays out the data structure that should be returned in the response. 



## The Google Knowledge Graph

Following the deprecation of the Freebase APIs, the new Knowledge Graph Search API (KG API) was released. As of April 2016, the new KG API does not support queries written in MQL as it did on Freebase. 

Further code to explore the Knowledge Graph API is in this [repository](https://github.com/nchah/knowledge-graph-api).


## Sources

Some sources may no longer be available following the deprecation of the Freebase API on June 30, 2015.

**Freebase**
- http://www.freebase.com/
- http://wiki.freebase.com/wiki/Main_Page

**Knowledge Graph**
- https://www.google.com/intl/bn/insidesearch/features/search/knowledge.html (Google Inside Search explaining the Knowledge Graph)

**Google Developers Resources**

*Freebase API*
- https://developers.google.com/freebase/
- https://developers.google.com/freebase/mql/

*Knowledge Graph Search API*
- https://plus.google.com/109936836907132434202/posts/iY8NZGFF6DN (released on Dec 16, 2015)
- https://developers.google.com/knowledge-graph/

