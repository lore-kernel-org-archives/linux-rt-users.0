From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Subject: Re: [PATCH RT] rtmutex: Flush block plug on __down_read()
Date: Wed, 9 Jan 2019 10:48:49 +0100
Message-ID: <20190109094849.m7idtma5hoew3eyp@linutronix.de>
References: <1546634001-4450-1-git-send-email-swood@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Thomas Gleixner <tglx@linutronix.de>,
        Mikulas Patocka <mpatocka@redhat.com>,
        linux-rt-users@vger.kernel.org, linux-kernel@vger.kernel.org
To: Scott Wood <swood@redhat.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1546634001-4450-1-git-send-email-swood@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-rt-users.vger.kernel.org

On 2019-01-04 15:33:21 [-0500], Scott Wood wrote:
> +	/*
> +	 * If sem->rtmutex blocks, the function sched_submit_work will not
> +	 * call blk_schedule_flush_plug (because tsk_is_pi_blocked would be
> +	 * true).  We must call blk_schedule_flush_plug here; if we don't
> +	 * call it, an I/O deadlock may occur.
> +	 */

I kept the original comment plus I replaced device-mapper with I/O (the
patch said already that it is not device-mapper specific and may occur
with ext4 as well).

Sebastian
