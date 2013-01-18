From: Steven Rostedt <rostedt@goodmis.org>
Subject: Re: 3.2 kernel?
Date: Fri, 18 Jan 2013 11:50:58 -0500
Message-ID: <1358527858.7383.21.camel@gandalf.local.home>
References: <CA+2XN5JRkNDi52k57fzXue1HjaqD5wJdZXLessMDz94mKfXc_A@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-15"
Content-Transfer-Encoding: 7bit
Cc: linux-rt-users@vger.kernel.org
To: Ho Wan Chan <smartboyhw@gmail.com>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from hrndva-omtalb.mail.rr.com ([71.74.56.122]:13473 "EHLO
	hrndva-omtalb.mail.rr.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751654Ab3ARQvA (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Fri, 18 Jan 2013 11:51:00 -0500
In-Reply-To: <CA+2XN5JRkNDi52k57fzXue1HjaqD5wJdZXLessMDz94mKfXc_A@mail.gmail.com>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

On Mon, 2012-12-10 at 22:35 +0800, Ho Wan Chan wrote:
> Hi guys.
> 
> Sorry if I have asked anything wrong, but now since the kernel is now
> at 3.2.35 but then the -rt patch is still at 3.2.34, I wondered why
> the .35 patch is still not yet released.
> 
> Anyway I tried applying the 3.2.34 patch onto 3.2.35 and it didn't
> give out any errors.

Wow, can we get more impatient. Yeah, I know this post is old but still.

After a release comes out, I rebase the work on top of it and run
several tests. Sometimes those tests fail, and I need to investigate.
Usually they are minor issues, or something that should be ignored.

I try to make sure the -rt patch comes out within a week of the main
release. But there's times that I may let it slide 2 weeks. After that,
then sure, start complaining.

BTW, just because we work on Real-Time software, doesn't mean that we
are real-time in life. Actually, RT developers are usually the latest to
get things done. Like me replying to this email now.

-- Steve


