access_token="${access_token}"
gitlab_URL="${gitlab_URL}"
group_name="${group_name}"
group_path="${group_path}"
default_branch="${default_branch:=master}"
visibility_repo="${visibility_repo:=private}"
projects_name="${projects_name}"


create_gitlab_group(){
    echo "Create a group"
    echo "${group_name}"
    echo "${group_path}"
    echo "${default_branch}"
    echo "${visibility_repo}"
    curl --request POST "${gitlab_URL}/groups" \
        --header "PRIVATE-TOKEN: ${access_token}" \
        --header "Content-Type:application/json" \
        --data '{
            "name":"'${group_name}'",
            "path":"'${group_path}'",
            "default_branch":"'${default_branch}'",
            "visibility":"'${visibility_repo}'"}'
    echo "End"
}

create_project_in_group(){

    namespace_id=$(curl --header "PRIVATE-TOKEN: ${access_token}" \
        "${gitlab_URL}/namespaces/${group_path}" | jq '.id')

    projects_name_list=$(echo $projects_name | tr "," "\n")

    for name in $projects_name_list
    do
        curl --request POST "${gitlab_URL}/projects"   \
            --header "PRIVATE-TOKEN: ${access_token}" \
            --header "Content-Type:application/json" \
            --data '{
                "name":"'${name}'",
                "namespace_id":"'${namespace_id}'",
                "default_branch":"'${default_branch}'"}'
    done
          
}


get_namespace_id(){
    namespace_id=$(curl --header "PRIVATE-TOKEN: ${access_token}" \
        "${gitlab_URL}/namespaces/${group_name}")

    return $namespace_id
}


