From: Chao Yu <chao2.yu@samsung.com>
Subject: RE: [PATCH] f2fs: mutex can't be used by down_write_nest_lock()
Date: Tue, 01 Mar 2016 16:59:39 +0800
Message-ID: <00d101d17398$dbbaca10$93305e30$@samsung.com>
References: <1456532725-4126-1-git-send-email-yang.shi@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Cc: linux-kernel@vger.kernel.org,
	linux-f2fs-devel@lists.sourceforge.net,
	linux-fsdevel@vger.kernel.org, linux-rt-users@vger.kernel.org,
	linaro-kernel@lists.linaro.org
To: 'Yang Shi' <yang.shi@linaro.org>, jaegeuk@kernel.org,
	cm224.lee@samsung.com, tglx@linutronix.de, rostedt@goodmis.org,
	bigeasy@linutronix.de
Return-path: <linux-kernel-owner@vger.kernel.org>
In-reply-to: <1456532725-4126-1-git-send-email-yang.shi@linaro.org>
Content-language: zh-cn
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-rt-users.vger.kernel.org

Hi Yang,

> -----Original Message-----
> From: Yang Shi [mailto:yang.shi@linaro.org]
> Sent: Saturday, February 27, 2016 8:25 AM
> To: jaegeuk@kernel.org; cm224.lee@samsung.com; chao2.yu@samsung.com; tglx@linutronix.de;
> rostedt@goodmis.org; bigeasy@linutronix.de
> Cc: linux-kernel@vger.kernel.org; linux-f2fs-devel@lists.sourceforge.net;
> linux-fsdevel@vger.kernel.org; linux-rt-users@vger.kernel.org;
> linaro-kernel@lists.linaro.org; yang.shi@linaro.org
> Subject: [PATCH] f2fs: mutex can't be used by down_write_nest_lock()
> 
> fsf2_lock_all() calls down_write_nest_lock() to acquire a rw_sem and check

Nitpick, f2fs_lock_all().

Anyway, this patch looks good to me.

Reviewed-by: Chao Yu <chao2.yu@samsung.com>
