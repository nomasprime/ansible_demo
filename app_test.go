package main

import (
    "fmt"
    "io/ioutil"
    "net/http"
    "net/http/httptest"
    "os"
    "testing"
)

func TestHandler(t *testing.T) {
    w := httptest.NewRecorder()
    r, _ := http.NewRequest("GET", "", nil)
    Handler(w, r)
    body, _ := ioutil.ReadAll(w.Body)
    hostname, _ := os.Hostname()
    expected := fmt.Sprintf("Hi there, I'm served from %s!", hostname)

    if string(body) != expected {
        t.Fatalf("Expected '%s' got '%s'", expected, body)
    }
}
