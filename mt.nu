# Lists featured threads (no auth required)
export def "featured threads" [] {
	(
		http get
			https://musicthread.app/api/v0/featured
	) | get threads
}

# Lists public threads for a specific account (no auth required)
export def "account threads" [
    --account_request: string
] {
	(
		http get
			$"https://musicthread.app/api/v0/account/($account_request)"
	) | get threads
}

# Fetches details of a specific thread by key (no auth required)
export def "thread info" [
    thread_key: string
] {
	(
		http get
			$"https://musicthread.app/api/v0/thread/($thread_key)"
	) | get thread
}

# Fetch your threads
export def "threads" [] {
	(
		http get --headers ["Authorization" $"Bearer ($env.MUSICTHREAD_API_TOKEN)"]
			https://musicthread.app/api/v0/threads
	) | get threads
}

# Fetch your bookmarks
export def "bookmarks" [] {
	(
		http get --headers ["Authorization" $"Bearer ($env.MUSICTHREAD_API_TOKEN)"]
			https://musicthread.app/api/v0/bookmarks
	) | get threads
}

# Creates a new thread
export def "thread create" [
	--title: string,
	--description: string = "",
	--tags: list<string> = [],
	--is_private = false
] {
	let body = {
		title: $title
		description: $description
		tags: $tags
		is_private: $is_private
	}
	(
		http post --headers ["Authorization" $"Bearer ($env.MUSICTHREAD_API_TOKEN)"]
			--content-type 'application/json'
			https://musicthread.app/api/v0/new-thread
			$body
	) | get thread
}

# Adds a new link to a thread
export def "thread add" [
	--url: string,
	--thread_key: string
] {
	let body = {
		url: $url
		thread: $thread_key
	}
	(
		http post --headers ["Authorization" $"Bearer ($env.MUSICTHREAD_API_TOKEN)"]
			--content-type 'application/json'
			https://musicthread.app/api/v0/add-link
			$body
	) | get link
}
