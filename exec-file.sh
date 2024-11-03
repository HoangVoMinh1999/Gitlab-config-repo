access_token="glpat-KXvZkEkKbx_wxMPSuzxC"
gitlab_URL="http://192.168.2.18/api/v4"
group_name="VHoang"
group_path="vhoang"
default_branch="" #default: master
visibility_repo="" #default: private
projects_name="vhoang_01,vhoang_02"

. ./create-gitlab-repo.sh 
# create_gitlab_group

create_project_in_group