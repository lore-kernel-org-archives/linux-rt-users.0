From: John Kacur <jkacur@redhat.com>
Subject: Re: [PATCH 2/4] Missing parsing of --mlockall in signaltest
Date: Tue, 22 Dec 2009 22:00:11 +0100 (CET)
Message-ID: <alpine.LFD.2.00.0912222155390.8838@localhost.localdomain>
References: <1261496858-12744-1-git-send-email-davids@redhat.com> <1261496858-12744-3-git-send-email-davids@redhat.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: linux-rt-users@vger.kernel.org,
	Clark Williams <williams@redhat.com>,
	Carsten Emde <carsten.emde@osadl.org>
To: David Sommerseth <davids@redhat.com>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:44601 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755051AbZLVVAX (ORCPT <rfc822;linux-rt-users@vger.kernel.org>);
	Tue, 22 Dec 2009 16:00:23 -0500
In-Reply-To: <1261496858-12744-3-git-send-email-davids@redhat.com>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>



On Tue, 22 Dec 2009, David Sommerseth wrote:

> Signed-off-by: David Sommerseth <davids@redhat.com>
> ---
>  src/signaltest/signaltest.c |    1 +
>  1 files changed, 1 insertions(+), 0 deletions(-)
> 
> diff --git a/src/signaltest/signaltest.c b/src/signaltest/signaltest.c
> index b637aae..24ac959 100644
> --- a/src/signaltest/signaltest.c
> +++ b/src/signaltest/signaltest.c
> @@ -235,6 +235,7 @@ static void process_options (int argc, char *argv[])
>  			{"quiet", no_argument, NULL, 'q'},
>  			{"threads", required_argument, NULL, 't'},
>  			{"verbose", no_argument, NULL, 'v'},
> +			{"mlockall", no_argument, NULL, 'm'},
>  			{"help", no_argument, NULL, '?'},
>  			{NULL, 0, NULL, 0}
>  		};
> -- 
> 1.6.2.5
> 
> 
Nice catch! I cced Carsten - as this is his code.

Clark I pushed this to
git://git.kernel.org/pub/scm/linux/kernel/git/jkacur/rt-tests.git
branch: rt-tests-dev-new

Please pull from there. (61b1309)

Thanks
