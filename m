From: Jaegeuk Kim <jaegeuk@kernel.org>
Subject: Re: [PATCH] f2fs: mutex can't be used by down_write_nest_lock()
Date: Wed, 2 Mar 2016 10:22:46 -0800
Message-ID: <20160302182246.GC9395@jaegeuk.gateway>
References: <1456532725-4126-1-git-send-email-yang.shi@linaro.org>
 <00d101d17398$dbbaca10$93305e30$@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: 'Yang Shi' <yang.shi@linaro.org>, cm224.lee@samsung.com,
	tglx@linutronix.de, rostedt@goodmis.org, bigeasy@linutronix.de,
	linux-kernel@vger.kernel.org,
	linux-f2fs-devel@lists.sourceforge.net,
	linux-fsdevel@vger.kernel.org, linux-rt-users@vger.kernel.org,
	linaro-kernel@lists.linaro.org
To: Chao Yu <chao2.yu@samsung.com>
Return-path: <linux-fsdevel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <00d101d17398$dbbaca10$93305e30$@samsung.com>
Sender: linux-fsdevel-owner@vger.kernel.org
List-Id: linux-rt-users.vger.kernel.org

On Tue, Mar 01, 2016 at 04:59:39PM +0800, Chao Yu wrote:
> Hi Yang,
> 
> > -----Original Message-----
> > From: Yang Shi [mailto:yang.shi@linaro.org]
> > Sent: Saturday, February 27, 2016 8:25 AM
> > To: jaegeuk@kernel.org; cm224.lee@samsung.com; chao2.yu@samsung.com; tglx@linutronix.de;
> > rostedt@goodmis.org; bigeasy@linutronix.de
> > Cc: linux-kernel@vger.kernel.org; linux-f2fs-devel@lists.sourceforge.net;
> > linux-fsdevel@vger.kernel.org; linux-rt-users@vger.kernel.org;
> > linaro-kernel@lists.linaro.org; yang.shi@linaro.org
> > Subject: [PATCH] f2fs: mutex can't be used by down_write_nest_lock()
> > 
> > fsf2_lock_all() calls down_write_nest_lock() to acquire a rw_sem and check

Fixed, and merged. :)

> 
> Nitpick, f2fs_lock_all().
> 
> Anyway, this patch looks good to me.
> 
> Reviewed-by: Chao Yu <chao2.yu@samsung.com>
