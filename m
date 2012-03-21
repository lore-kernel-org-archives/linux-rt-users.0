From: Steven Rostedt <rostedt@goodmis.org>
Subject: Re: [PATCH 2/3] rt-tests: Silence unused-but-set warning in
 rt-migrate-test
Date: Wed, 21 Mar 2012 10:05:31 -0400
Message-ID: <1332338731.23924.40.camel@gandalf.stny.rr.com>
References: <3343440fb02872debc8b49be5261aec530a205f3.1332270303.git.dvhart@linux.intel.com>
	 <b1216a51f76a038623057621a737d02a4ab441e4.1332270303.git.dvhart@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-15"
Content-Transfer-Encoding: 7bit
Cc: linux-rt-users@vger.kernel.org,
	Clark Williams <williams@redhat.com>,
	John Kacur <jkacur@redhat.com>
To: Darren Hart <dvhart@linux.intel.com>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from hrndva-omtalb.mail.rr.com ([71.74.56.122]:14579 "EHLO
	hrndva-omtalb.mail.rr.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1030943Ab2CUOFc (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Wed, 21 Mar 2012 10:05:32 -0400
In-Reply-To: <b1216a51f76a038623057621a737d02a4ab441e4.1332270303.git.dvhart@linux.intel.com>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

On Tue, 2012-03-20 at 12:05 -0700, Darren Hart wrote:

> diff --git a/src/rt-migrate-test/rt-migrate-test.c b/src/rt-migrate-test/rt-migrate-test.c
> index 1963641..d2ac400 100644
> --- a/src/rt-migrate-test/rt-migrate-test.c
> +++ b/src/rt-migrate-test/rt-migrate-test.c
> @@ -532,7 +532,7 @@ int main (int argc, char **argv)
>  	logdev_switch_set(1);
>  
>  	for (loop=0; loop < nr_runs; loop++) {
> -		unsigned long long end;
> +		unsigned long long __attribute__ ((unused)) end;

I don't like this. It seems to be a gcc bug. What version of gcc is
this?

-- Steve


>  
>  		now = get_time();
>  


