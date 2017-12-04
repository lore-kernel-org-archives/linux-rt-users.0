From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Subject: Re: [PATCH RT 02/15] Revert "fs: jbd2: pull your plug when waiting
 for space"
Date: Mon, 4 Dec 2017 09:37:53 +0100
Message-ID: <20171204083752.GA2255@linutronix.de>
References: <20171202000149.842718953@goodmis.org>
 <20171202000427.022777641@goodmis.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: linux-kernel@vger.kernel.org,
        linux-rt-users <linux-rt-users@vger.kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Carsten Emde <C.Emde@osadl.org>,
        John Kacur <jkacur@redhat.com>,
        Paul Gortmaker <paul.gortmaker@windriver.com>,
        Julia Cartwright <julia@ni.com>,
        Daniel Wagner <daniel.wagner@siemens.com>,
        tom.zanussi@linux.intel.com, Alex Shi <alex.shi@linaro.org>,
        stable-rt@vger.kernel.org
To: Steven Rostedt <rostedt@goodmis.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20171202000427.022777641@goodmis.org>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-rt-users.vger.kernel.org

On 2017-12-01 19:01:51 [-0500], Steven Rostedt wrote:
> 4.9.65-rt57-rc2 stable review patch.
> If anyone has any objections, please let me know.

I don't see that you pulled in
locking-rt-mutex-fix-deadlock-in-device-mapper-block.patch
|Subject: [PATCH] locking/rt-mutex: fix deadlock in device mapper / block-IO

which is needed before this can go in.

> ------------------
> 
> From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
> 
> This reverts commit "fs: jbd2: pull your plug when waiting for space".
> This was a duct-tape fix which shouldn't be needed since commit
> "locking/rt-mutex: fix deadlock in device mapper / block-IO".
> 
> Cc: stable-rt@vger.kernel.org
> Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
> Signed-off-by: Steven Rostedt (VMware) <rostedt@goodmis.org>
> ---
>  fs/jbd2/checkpoint.c | 2 --
>  1 file changed, 2 deletions(-)
> 
> diff --git a/fs/jbd2/checkpoint.c b/fs/jbd2/checkpoint.c
> index 6e18a06aaabe..684996c8a3a4 100644
> --- a/fs/jbd2/checkpoint.c
> +++ b/fs/jbd2/checkpoint.c
> @@ -116,8 +116,6 @@ void __jbd2_log_wait_for_space(journal_t *journal)
>  	nblocks = jbd2_space_needed(journal);
>  	while (jbd2_log_space_left(journal) < nblocks) {
>  		write_unlock(&journal->j_state_lock);
> -		if (current->plug)
> -			io_schedule();
>  		mutex_lock(&journal->j_checkpoint_mutex);
>  
>  		/*

Sebastian
