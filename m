Return-Path: <SRS0=9Pks=WM=vger.kernel.org=linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C47C3C3A59C
	for <linux-rt-users@archiver.kernel.org>; Fri, 16 Aug 2019 15:41:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9858D20644
	for <linux-rt-users@archiver.kernel.org>; Fri, 16 Aug 2019 15:41:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727444AbfHPPlf convert rfc822-to-8bit (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Fri, 16 Aug 2019 11:41:35 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:42631 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727376AbfHPPlf (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Fri, 16 Aug 2019 11:41:35 -0400
Received: from bigeasy by Galois.linutronix.de with local (Exim 4.80)
        (envelope-from <bigeasy@linutronix.de>)
        id 1hyeM8-0003xl-PZ; Fri, 16 Aug 2019 17:41:32 +0200
Date:   Fri, 16 Aug 2019 17:41:32 +0200
From:   Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To:     Daniel Wagner <wagi@monom.org>
Cc:     Clark Williams <williams@redhat.com>,
        John Kacur <jkacur@redhat.com>, linux-rt-users@vger.kernel.org
Subject: Re: [PATCH rt-tests v0 1/4] pmqtest: Increase buffer to avoid
 overflow
Message-ID: <20190816154132.xk5u7di6d5jdzw5v@linutronix.de>
References: <20190816064204.6339-1-wagi@monom.org>
 <20190816064204.6339-2-wagi@monom.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8BIT
In-Reply-To: <20190816064204.6339-2-wagi@monom.org>
User-Agent: NeoMutt/20180716
Sender: linux-rt-users-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org

On 2019-08-16 08:42:01 [+0200], Daniel Wagner wrote:
> Increase the size of the char buffer. gcc 9.1.1 reports:
> 
> src/pmqtest/pmqtest.c: In function ‘main’:
> src/pmqtest/pmqtest.c:46:21: warning: ‘%d’ directive writing between 1 and 10 bytes into a region of size 8 [-Wformat-overflow=]
>    46 | #define SYNCMQ_NAME "/syncmsg%d"
>       |                     ^~~~~~~~~~~~
> 
> src/pmqtest/pmqtest.c:445:3: note: ‘sprintf’ output between 10 and 19 bytes into a destination of size 16
>   445 |   sprintf(mqname, SYNCMQ_NAME, i);
>       |   ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> 
> Signed-off-by: Daniel Wagner <wagi@monom.org>
> ---
>  src/pmqtest/pmqtest.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/src/pmqtest/pmqtest.c b/src/pmqtest/pmqtest.c
> index a04fc49872bf..20164c8d547f 100644
> --- a/src/pmqtest/pmqtest.c
> +++ b/src/pmqtest/pmqtest.c
> @@ -440,7 +440,7 @@ int main(int argc, char *argv[])
>  		goto nomem;
>  
>  	for (i = 0; i < num_threads; i++) {
> -		char mqname[16];
> +		char mqname[32];

The compiler says, based on SYNCMQ_NAME's size and maximum possible %d
we will have 19 bytes max. Why do you change it to 32? Why it is not
wrong, one might ask what the extra storage is for.

Sebastian
