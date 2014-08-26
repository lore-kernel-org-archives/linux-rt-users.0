From: Steven Rostedt <rostedt@goodmis.org>
Subject: Re: [PATCH -rt 3.10.x] mce: don't try to wake thread before it
 exists.
Date: Tue, 26 Aug 2014 19:07:03 -0400
Message-ID: <20140826190703.57a93cf7@gandalf.local.home>
References: <1409091053-45412-1-git-send-email-paul.gortmaker@windriver.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Cc: <linux-rt-users@vger.kernel.org>
To: Paul Gortmaker <paul.gortmaker@windriver.com>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from cdptpa-outbound-snat.email.rr.com ([107.14.166.230]:54531 "EHLO
	cdptpa-oedge-vip.email.rr.com" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1755522AbaHZXIH (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Tue, 26 Aug 2014 19:08:07 -0400
In-Reply-To: <1409091053-45412-1-git-send-email-paul.gortmaker@windriver.com>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

On Tue, 26 Aug 2014 18:10:53 -0400
Paul Gortmaker <paul.gortmaker@windriver.com> wrote:

> diff --git a/arch/x86/kernel/cpu/mcheck/mce.c b/arch/x86/kernel/cpu/mcheck/mce.c
> index aaf4b9b94f38..94860c521fb8 100644
> --- a/arch/x86/kernel/cpu/mcheck/mce.c
> +++ b/arch/x86/kernel/cpu/mcheck/mce.c
> @@ -1391,6 +1391,11 @@ static int mce_notify_work_init(void)
>  
>  static void mce_notify_work(void)
>  {
> +	if (unlikely(!mce_notify_helper)) {
> +		pr_info(HW_ERR "Machine check event before MCE init; ignored\n");

Hmm, maybe we should make this a bit more noticeable?  Not just an
"ignored" event with pr_info(). Maybe a:

	if (WARN_ON_ONCE(!mce_notify_helper)) {

-- Steve

> +		return;
> +	}
> +
>  	wake_up_process(mce_notify_helper);
>  }
>  #else

