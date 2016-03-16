From: John Kacur <jkacur@redhat.com>
Subject: Re: [PATCH 1/4] pip_stress: drop unused variable
Date: Wed, 16 Mar 2016 23:00:37 +0100 (CET)
Message-ID: <alpine.LFD.2.20.1603162257350.16977@riemann>
References: <1456346981-24032-1-git-send-email-lcapitulino@redhat.com> <1456346981-24032-2-git-send-email-lcapitulino@redhat.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; BOUNDARY="-1463804494-2024697467-1458165647=:16977"
Cc: linux-rt-users@vger.kernel.org, williams@redhat.com
To: Luiz Capitulino <lcapitulino@redhat.com>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from mail-wm0-f65.google.com ([74.125.82.65]:35528 "EHLO
	mail-wm0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932071AbcCPWAt (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Wed, 16 Mar 2016 18:00:49 -0400
Received: by mail-wm0-f65.google.com with SMTP id l124so5644899wmf.2
        for <linux-rt-users@vger.kernel.org>; Wed, 16 Mar 2016 15:00:49 -0700 (PDT)
In-Reply-To: <1456346981-24032-2-git-send-email-lcapitulino@redhat.com>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

---1463804494-2024697467-1458165647=:16977
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT



On Wed, 24 Feb 2016, Luiz Capitulino wrote:

> src/pi_tests/pip_stress.c: In function ‘main’:
> src/pi_tests/pip_stress.c:94:6: warning: unused variable ‘c’ [-Wunused-variable]
> 
> Signed-off-by: Luiz Capitulino <lcapitulino@redhat.com>
> ---
>  src/pi_tests/pip_stress.c | 1 -
>  1 file changed, 1 deletion(-)
> 
> diff --git a/src/pi_tests/pip_stress.c b/src/pi_tests/pip_stress.c
> index 66b3dc1..812a703 100644
> --- a/src/pi_tests/pip_stress.c
> +++ b/src/pi_tests/pip_stress.c
> @@ -91,7 +91,6 @@ int main(void)
>  	cpu_set_t set, *setp = &set;
>  	int res;
>  	int *minimum_priority = (int*)&prio_min;
> -	int c;
>  
>  	*minimum_priority = sched_get_priority_min(policy);
>  
> -- 
> 2.1.0

Where are you getting your repo from?
According to my logs this was already fixed on June 30, 2015

The current repo is at
git://git.kernel.org/pub/scm/utils/rt-tests/rt-tests.git

Thanks
---1463804494-2024697467-1458165647=:16977--
