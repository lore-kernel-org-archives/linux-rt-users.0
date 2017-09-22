From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Subject: Re: RT kernel on Acer laptop unreliable
Date: Fri, 22 Sep 2017 09:40:50 +0200
Message-ID: <20170922074050.pjtyzzd2n2khtxsn@linutronix.de>
References: <8c1a0cb6-d90c-1f6f-2d23-9865a17b379e@jajcus.net>
 <20170807131937.ijj7n4yuk6inds4h@linutronix.de>
 <56cb9f42-83e3-6648-2489-7c9e486c8ecc@jajcus.net>
 <20170818124406.6cem4po52xrzi5qc@linutronix.de>
 <b1209f35-67a2-5cb2-d0e1-ad142b34aab9@jajcus.net>
 <20170821131254.5nuacfv62d3l4rhe@linutronix.de>
 <52e67cfd-0bb3-ce97-7b28-f2afb1d3c1cb@jajcus.net>
 <20170905091712.koywolqt5qwaslpk@linutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: linux-rt-users@vger.kernel.org
To: Jacek Konieczny <jajcus@jajcus.net>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from Galois.linutronix.de ([146.0.238.70]:38126 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751795AbdIVHkz (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Fri, 22 Sep 2017 03:40:55 -0400
Content-Disposition: inline
In-Reply-To: <20170905091712.koywolqt5qwaslpk@linutronix.de>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

On 2017-09-05 11:17:13 [+0200], To Jacek Konieczny wrote:
> I'm sorry, I missed that. What about this on-top?
> 
> diff --git a/include/linux/locallock.h b/include/linux/locallock.h
> index eeb1a66df402..298afcd8e219 100644
> --- a/include/linux/locallock.h
> +++ b/include/linux/locallock.h
> @@ -61,6 +61,9 @@ static inline int __local_trylock(struct local_irq_lock *lv)
>  		lv->owner = current;
>  		lv->nestcnt = 1;
>  		return 1;
> +	} else if (lv->owner == current) {
> +		lv->nestcnt++;
> +		return 1;
>  	}
>  	return 0;
>  }

I am going to split up that part out in a separate patch and also add
the !RT part to it.

--- a/include/linux/locallock.h
+++ b/include/linux/locallock.h
@@ -68,6 +68,9 @@ static inline int __local_trylock(struct
 		lv->owner = current;
 		lv->nestcnt = 1;
 		return 1;
+	} else if (lv->owner == current) {
+		lv->nestcnt++;
+		return 1;
 	}
 	return 0;
 }
@@ -238,6 +241,12 @@ static inline int __local_unlock_irqrest
 
 static inline void local_irq_lock_init(int lvar) { }
 
+#define local_trylock(lvar)					\
+	({							\
+		preempt_disable();				\
+		1;						\
+	})
+
 #define local_lock(lvar)			preempt_disable()
 #define local_unlock(lvar)			preempt_enable()
 #define local_lock_irq(lvar)			local_irq_disable()
