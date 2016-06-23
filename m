From: Steven Rostedt <rostedt@goodmis.org>
Subject: Re: [PATCH 3/3] rt-tests: Add cyclicdeadline and deadline_test to
 the Make system
Date: Thu, 23 Jun 2016 17:47:46 -0400
Message-ID: <20160623174746.36d3657d@gandalf.local.home>
References: <1466683911-10994-1-git-send-email-jkacur@redhat.com>
	<1466683911-10994-4-git-send-email-jkacur@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Cc: rt-users <linux-rt-users@vger.kernel.org>,
	lkml <linux-kernel@vger.kernel.org>,
	Clark Williams <williams@redhat.com>
To: John Kacur <jkacur@redhat.com>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from smtprelay0100.hostedemail.com ([216.40.44.100]:50258 "EHLO
	smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1751255AbcFWVrv (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Thu, 23 Jun 2016 17:47:51 -0400
In-Reply-To: <1466683911-10994-4-git-send-email-jkacur@redhat.com>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

On Thu, 23 Jun 2016 14:11:51 +0200
John Kacur <jkacur@redhat.com> wrote:


> index 9c50456f7419..f530488545e0 100644
> --- a/src/sched_deadline/cyclicdeadline.c
> +++ b/src/sched_deadline/cyclicdeadline.c
> @@ -1,4 +1,6 @@
> +#ifndef _GNU_SOURCE
>  #define _GNU_SOURCE
> +#endif
>  #include <pthread.h>
>  #include <stdarg.h>
>  #include <stdlib.h>
> diff --git a/src/sched_deadline/deadline_test.c b/src/sched_deadline/deadline_test.c
> index 8a813c494520..2794730febc4 100644
> --- a/src/sched_deadline/deadline_test.c
> +++ b/src/sched_deadline/deadline_test.c
> @@ -29,7 +29,9 @@
>   *    Look for "simple_test"
>   *
>   */
> +#ifndef _GNU_SOURCE
>  #define _GNU_SOURCE
> +#endif

I'd say nuke these if they are already defined via the Makefile or
something. I can move the define to the Makefile in my github too.

-- Steve

>  #include <pthread.h>
>  #include <stdarg.h>
>  #include <stdlib.h>

