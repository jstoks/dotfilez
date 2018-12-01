alias dexec="docker-compose exec"
alias dcomposer="docker-compose exec composer php composer"
alias dartisan="docker-compose exec app php artisan"

function dphp() {
  docker-compose exec "$1" php "${@:2}"
}
