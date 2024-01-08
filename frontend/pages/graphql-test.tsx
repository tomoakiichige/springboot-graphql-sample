import { gql } from '@/__generated__';
import { useEffect } from 'react';
import { useQuery } from '@apollo/client';

const GET_USERS = gql(/* GraphQL */ `
  query GetUsers {
    users {
      id
      username
      articles {
        id
        title
      }
    }
  }
`);

const GraphqlTest = () => {
  const { loading, data } = useQuery(GET_USERS);

  useEffect(() => {
    console.log(data);
  }, [data]);

  return (
    <div>
      {loading ? (
        <div>Loading...</div>
      ) : (
        <ul>
          {data?.users.map((user) => (
            <li key={user.id}>
              {user.id} {user.username}
              <ul>
                {user.articles.map((article) => (
                  <li key={article.id}>
                    {article.id} {article.title}
                  </li>
                ))}
              </ul>
            </li>
          ))}
        </ul>
      )}
    </div>
  );
};

export default GraphqlTest;
