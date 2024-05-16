echo_output=true

conditional_echo() {
    local input=$1
    if [ $echo_output = true ]; then
        echo $input
    fi
}

while getopts "dje" opt; do
  case ${opt} in 
    d )
      # echo "renaming duplicates"
      rename_duplicates
      ;;
    e )
      # echo "detecting fake pngs and turning them into jpegs"
      echo_output=false
      ;;
    \? )
      echo "Usage: cmd [-a] [-b] [-c]"
      exit 1
      ;;
  esac
done

conditional_echo "hello"