const String readRepository = r'''
query getRepositoryDetail($owner:String!, $name:String!) {
  repositoty(name: $name, owner: $owner) {
    ...comparisonFields
    parent {
      ...comparisonFields
    }
  }
}
fragment comparisonFields on Repository {
  issuesClosed: issues(states : CLOSED) {
    totalCount
  }
  issuesOpen: issues(states : OPEN) {
    totalCount
  }
  issues {
    totalCount
  }
  nameWithOwner,
  id,
  name,
  owner {
    login,
    url,
    avatarurl,
  },
  licenseInfo {
    name
  }
  forkCount,
  stargazers {
    totalCount
  }
  hasIssuesEnabled,
  viewerHasStarred,
  viewerSubscription,
  hasIssuesEnabled,
  defaultBranchRef {
    name
  },
  watchers {
    totalCounter,
  },
  isFork,
  languages(first:100) {
    totalSize,
    nodes {
      name,
    }
  },
  createdAt,
  pushedAt,
  pushedAt,
  sshUrl,
  url,
  shortDescriptionHTML,
  repositoryTopics(first: 100) {
    totalCount,
    nodes {
      topic {
        name,
      }
    }
  }
}
''';