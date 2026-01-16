Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D1832D77FF
	for <linux-rt-users@vger.kernel.org>; Fri, 16 Jan 2026 15:32:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768577530; cv=none; b=iozYns4QnCRrSzQ2uw4QQWF4Q3CSFwSvcK4dI0Gqt3rXB/tFRiwNr+ryEN54tvLBka1Jt9igzD5yvKvk+anywCE/bIWc8P3N/G3uqzBbVXwdsphcK8JqMVOE6XiCyp28jzsnLt+Q9TNPYyW+KCJzs5IFNxOzv2Hg+EFcYLvO7lU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768577530; c=relaxed/simple;
	bh=hTFBET+ZmhwqyBuCuqXbIZujd+Y7gVUqLwa3g6E4vEI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=mhpXDjXVhsW70U4WqdBJwZI3qFU2/NPERPClXTbusZqsqedwpfGKYTSlOhRKtZfRK+qZfoRKvZlXrkG9gCBMGBXwNhgCYV2XG6NGdMp3i8vlo8jQAM7u1IhVh72yjaFJbOEwib40UeF/WOfADcsES4crydCe2IhDa9lhSCxMIqU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=SIIzZxqs; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="SIIzZxqs"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1768577527;
	h=from:from:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:in-reply-to:in-reply-to:  references:references;
	bh=/f0OLTqqI3s+E9BcrY6vr2mweV6i7sJIfZOKR0i5gO0=;
	b=SIIzZxqsF8hGU8sd5Z/jXNCkYMkYj/TjEehNOyTV8VntH7wwqNw+gN8Leck7M+O1CsBgBB
	JobYMJIuH/FQnYRjUlgkpo8bjBXhxxTDLFWx+5+g7yM1FQb6OEfV9ylUOJGSuZYI7XwYR+
	ML4T3OXpT8JwlUTzs3eeTtVFGPO5tNQ=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-299-5UXg6TF1NOGLJmcBqGbj7Q-1; Fri,
 16 Jan 2026 10:32:04 -0500
X-MC-Unique: 5UXg6TF1NOGLJmcBqGbj7Q-1
X-Mimecast-MFC-AGG-ID: 5UXg6TF1NOGLJmcBqGbj7Q_1768577523
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 9BD0918003FC
	for <linux-rt-users@vger.kernel.org>; Fri, 16 Jan 2026 15:32:03 +0000 (UTC)
Received: from localhost (unknown [10.22.65.145])
	by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 49F82195419D;
	Fri, 16 Jan 2026 15:32:03 +0000 (UTC)
Date: Fri, 16 Jan 2026 10:32:02 -0500
From: Derek Barbosa <debarbos@redhat.com>
To: Attila Fazekas <afazekas@redhat.com>
Cc: williams@redhat.com, jkacur@redhat.com, linux-rt-users@vger.kernel.org, 
	lgoncalv@redhat.com
Subject: Re: [PATCH] [ssdd] add ptrace tierdown for the tests
Message-ID: <h2hr4lil5kryxon7shmf6vo45uuj5gzkh5d5hvhm63airlrufw@utykzy6jdqd6>
Reply-To: debarbos@redhat.com
References: <20260116083736.27032-1-afazekas@redhat.com>
Precedence: bulk
X-Mailing-List: linux-rt-users@vger.kernel.org
List-Id: <linux-rt-users.vger.kernel.org>
List-Subscribe: <mailto:linux-rt-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rt-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260116083736.27032-1-afazekas@redhat.com>
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17

On Fri, Jan 16, 2026 at 03:37:36AM -0500, Attila Fazekas wrote:
> Without tierdown the tracee can receive SIGTRAP
> leading to multiple core dumps being created.
> At higher concurrency you may also see
> 
> coredump: 11747(ssdd): over core_pipe_limit, skipping core dump
> 
> in the dmesg with
> kernel.core_pattern = |/usr/lib/systemd/systemd-coredump %P %u %g %s %t %c %h %d %F
> kernel.core_pipe_limit = 16
> 
> Signed-off-by: Attila Fazekas <afazekas@redhat.com>
> ---
>  src/ssdd/ssdd.c | 18 ++++++++++++++++--
>  1 file changed, 16 insertions(+), 2 deletions(-)
> 
> diff --git a/src/ssdd/ssdd.c b/src/ssdd/ssdd.c
> index 63130cd..61aab84 100644
> --- a/src/ssdd/ssdd.c
> +++ b/src/ssdd/ssdd.c
> @@ -312,9 +312,23 @@ static int forktests(int testid)
>  		got_sigchld = 0;
>  	}
>  
> -	/* There is no need for the tracer to kill the tracee. It will
> -	 * automatically exit when its owner, ie, us, exits.
> +	/* The tracee can receive SIGTRAP(dump) without detaching.
>  	 */
> +	pstatus = ptrace(PTRACE_DETACH, child, NULL, NULL);
> +	if (pstatus == ~0l) {
> +		printf("forktest#%d/%d: EXITING, ERROR: "
> +		       "detach failed.  errno %d\n",
> +		       testid, getpid(), errno);
> +		exit(1);
> +	}
> +	pstatus = kill(child, SIGKILL);
> +	if (pstatus != 0) {
> +		printf("forktest#%d/%d: EXITING, ERROR: "
> +		       "kill failed.  errno %d\n",
> +                       testid, getpid(), errno);
> +		exit(1);
> +	}
> +
>  	if (!quiet)
>  		printf("forktest#%d/%d: EXITING, no error\n", testid, parent);
>  	exit(0);
> -- 
> 2.52.0
> 

CC-ing lgoncalv from off-list convo.

From man 2 ptrace:
	If the tracer dies, all tracees are automatically detached and
    restarted, unless they were in group-stop.

From our off-list conversation (and the previous comment in the code itself) it
appears to be expected that there is no need for kill() to perform a final
cleanup. That doesn't seem to be the case as you noted the process still remains
without it.

I'm unsure if this is known behavior or not. Or I could just be misinterpreting
it :)

Anyway, Luis, you mentioned

> There are many other places where the results of the ptrace call needs to be
> checked in order to either repeat the OP or fail the whole process for being
> in a different state than expected

Should we propose that the added snippet above (detach, kill) be moved into a
helper, and called in lieu of `exit(1)` in the many if-blocks where we check to
see if the tracee is being stepped?

John, Clark, any thoughts?

-- 
Derek <debarbos@redhat.com>

