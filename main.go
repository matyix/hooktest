package main

import (
	"fmt"
	"github.com/gin-gonic/gin"
	"github.com/google/go-github/github"
	"io/ioutil"
	_log "log"
)

func main() {

	router := gin.Default()

	v1 := router.Group("/api/v1/")
	{
		v1.POST("/webhook", PostHook)

	}
	router.Run(":8080")

}

func PostHook(c *gin.Context) {
	_log.Println(c.Request.Body)

	payload, err := ioutil.ReadAll(c.Request.Body)
	if err != nil {
		_log.Printf("error reading request body: err=%s\n", err)
		return
	}
	event, err := github.ParseWebHook(github.WebHookType(c.Request), payload)
	if err != nil {
		_log.Printf("could not parse webhook: err=%s\n", err)
		return
	}
	switch e := event.(type) {
	case *github.PushEvent:
		// this is a commit push, do something with it
	case *github.PullRequestEvent:
		// this is a pull request, do something with it
	case *github.WatchEvent:
		// https://developer.github.com/v3/activity/events/types/#watchevent
		// someone starred our repository
		if e.Action != nil && *e.Action == "starred" {
			fmt.Printf("%s starred repository %s\n",
				*e.Sender.Login, *e.Repo.FullName)
		}
	default:
		_log.Printf("unknown event type %s\n", github.WebHookType(c.Request))
		return
	}

}
