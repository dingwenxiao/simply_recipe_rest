API REST for Sinatra
================================

-----

This is a simple rest api for recipes.
No database access and assume there is only one record exits:
{id:1, name:'name', instructions:'instructions',ingredients:'ingredients'} 


For test the API you can use the file extracted from PostMan or use these URIs in your Rest Client.


| Method | URI | Data | HTTP Code | Response (in JSON) |
| ------ | --- | ---- | --------- | ------------------ |
| GET | /listAll?page=0&&size=2 |  | 200 | {"id":"1", "name":"name", "instructions":"instructions","ingredients":"ingredients","linkself": "/listAll?page=0","linkprev": "","linknext": "/listAll?page=1"} |
| GET | /listAll?page=1&&size=2 |  | 404 |  |
| GET | /employees/6 |  | 404 | {"error":"Not found 6"} |
| POST | /addRecipe | {name":"name1", "instructions":"instructions","ingredients":"ingredients"} | 201 | {"id":"2", "name":"name1", "instructions":"instructions","ingredients":"ingredients"} |
| POST | /addRecipe | {name":"name", "instructions":"instructions","ingredients":"ingredients"}  | 409 | {"The recipe already exists"} |
| POST | /updateRecipe | {name":"name2", "instructions":"instructions1","ingredients1":"ingredients1"}  | 404 | {"Not Found Recipe Name - name2"} |
| DELETE | /removeRecipe/1 |  | 204 | |
| DELETE | /removeRecipe/2 |  | 404 | {"Not Found id: 2"} |
