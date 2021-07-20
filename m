Return-Path: <linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.7 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,UNPARSEABLE_RELAY,URIBL_BLOCKED autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E87B0C07E95
	for <linux-rt-users@archiver.kernel.org>; Tue, 20 Jul 2021 12:04:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C100C611C1
	for <linux-rt-users@archiver.kernel.org>; Tue, 20 Jul 2021 12:04:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237053AbhGTLXW (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Tue, 20 Jul 2021 07:23:22 -0400
Received: from smtprelay0223.hostedemail.com ([216.40.44.223]:39294 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S233914AbhGTLXW (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Tue, 20 Jul 2021 07:23:22 -0400
X-Greylist: delayed 506 seconds by postgrey-1.27 at vger.kernel.org; Tue, 20 Jul 2021 07:23:22 EDT
Received: from smtprelay.hostedemail.com (10.5.19.251.rfc1918.com [10.5.19.251])
        by smtpgrave05.hostedemail.com (Postfix) with ESMTP id 563D81848F042
        for <linux-rt-users@vger.kernel.org>; Tue, 20 Jul 2021 11:55:34 +0000 (UTC)
Received: from omf19.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay05.hostedemail.com (Postfix) with ESMTP id F1CD118482299;
        Tue, 20 Jul 2021 11:55:32 +0000 (UTC)
Received: from [HIDDEN] (Authenticated sender: joe@perches.com) by omf19.hostedemail.com (Postfix) with ESMTPA id 4808120D772;
        Tue, 20 Jul 2021 11:55:31 +0000 (UTC)
Message-ID: <ea6c6a2b5482d62038d7d0a1d46b87665051222f.camel@perches.com>
Subject: Re: [PREEMPT_RT][PATCH] printk: Enhance the condition check of
 msleep in pr_flush()
From:   Joe Perches <joe@perches.com>
To:     chao.qin@intel.com, linux-kernel@vger.kernel.org,
        linux-rt-users@vger.kernel.org, bigeasy@linutronix.de,
        tglx@linutronix.de, john.ogness@linutronix.de, rostedt@goodmis.org
Cc:     mgross@linux.intel.com, paul.mei@intel.com, lili.li@intel.com
Date:   Tue, 20 Jul 2021 04:55:29 -0700
In-Reply-To: <20210719022649.3444072-1-chao.qin@intel.com>
References: <20210719022649.3444072-1-chao.qin@intel.com>
Content-Type: text/plain; charset="ISO-8859-1"
User-Agent: Evolution 3.40.0-1 
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Stat-Signature: 3dgewkmzwze68eyrw5xr73gyy87o5dp7
X-Rspamd-Server: rspamout01
X-Rspamd-Queue-Id: 4808120D772
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-Session-ID: U2FsdGVkX1/EC7uj13DY6ao2cE/EXIkkovA/jyc+/1Y=
X-HE-Tag: 1626782131-563332
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org

On Mon, 2021-07-19 at 10:26 +0800, chao.qin@intel.com wrote:
> From: Chao Qin <chao.qin@intel.com>
> 
> There is msleep in pr_flush(). If call WARN() in the early boot
> stage such as in early_initcall, pr_flush() will run into msleep
> when process scheduler is not ready yet. And then the system will
> sleep forever.
> 
> Before the system_state is SYSTEM_RUNNING, make sure DO NOT sleep
> in pr_flush().

Makes sense, thanks.

> diff --git a/kernel/printk/printk.c b/kernel/printk/printk.c
[]
> @@ -3620,7 +3620,8 @@ bool pr_flush(int timeout_ms, bool reset_on_progress)
>  	u64 diff;
>  	u64 seq;
> 
> -	may_sleep = (preemptible() && !in_softirq());
> +	may_sleep = (preemptible() && !in_softirq()
> +			&& (system_state >= SYSTEM_RUNNING));

trivial style note:

Logic continuations are typically at the end of the previous line.
And there are few too many parentheses for my taste.

Maybe exceed 80 columns in a single line

	may_sleep = preemptible() && !in_softirq() && system_state >= SYSTEM_RUNNING;

or align the continuation

	may_sleep = (preemptible() && !in_softirq() &&
		     system_state >= SYSTEM_RUNNING);

or use individual lines

	may_sleep = (preemptible() &&
		     !in_softirq() &&
		     system_state >= SYSTEM_RUNNING);



