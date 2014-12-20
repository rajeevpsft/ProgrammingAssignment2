## R Class programming assignment 2


## This is a function to cache the inverse of a matrix
## An inverse is a matrix whose determinant is not 0

makeCacheMatrix <- function(x = matrix ()) {
  i <- NULL
  get <- function() x
  set <- function(y) {
    x <<- y
    i <<- NULL
  }
  setinv <- function(inv) i <<- inv
  getinv <- function() i
  list(set = set, get = get,
       setinv = setinv,
       getinv = getinv)
  
}

## This function checks if the inverse is cached and returns it if it is. 
## If not, it calls the setinv function above to compute the inverse

cachesolve <- function(x, ...) {
  i <- x$getinv()
  if(!is.null(i)) {
    message("getting cached data")
    return(i)
  }
  data <- x$get()
  i <- solve(data, ...)
  x$setinv(i)
  i
}
