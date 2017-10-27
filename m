From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Subject: Re: [patch-rt] drivers/zram: pass num_pages to
 zram_meta_init_table_locks()
Date: Fri, 27 Oct 2017 16:59:45 +0200
Message-ID: <20171027145945.fexsind2urzbbs5n@linutronix.de>
References: <20171017152952.6ab7qsgeqgisqci4@linutronix.de>
 <1508387247.12823.38.camel@gmx.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Thomas Gleixner <tglx@linutronix.de>,
        LKML <linux-kernel@vger.kernel.org>,
        linux-rt-users <linux-rt-users@vger.kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>
To: Mike Galbraith <efault@gmx.de>
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1508387247.12823.38.camel@gmx.de>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-rt-users.vger.kernel.org

On 2017-10-19 06:27:27 [+0200], Mike Galbraith wrote:
> 
> zram cleanup forgot to adjust passed argument when changing
> zram_meta_init_table_locks() to expect page count instead
> of disk size.  Doing so fixes ltp inspired explosions.

Thank you. Since only v4.13-RT is affected, I merged this into the
original patch.

> Signed-off-by: Mike Galbraith <efault@gmx.de>

Sebastian
