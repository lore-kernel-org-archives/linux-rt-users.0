From: Corey Minyard <cminyard@mvista.com>
Subject: Re: [PATCH RT 2/5] a few open coded completions
Date: Wed, 11 Dec 2013 08:25:29 -0600
Message-ID: <52A875D9.6090609@mvista.com>
References: <20131211003732.351606520@goodmis.org> <20131211003801.836995968@goodmis.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Thomas Gleixner <tglx@linutronix.de>,
	Carsten Emde <C.Emde@osadl.org>,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	John Kacur <jkacur@redhat.com>
To: Steven Rostedt <rostedt@goodmis.org>, linux-kernel@vger.kernel.org,
	linux-rt-users <linux-rt-users@vger.kernel.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20131211003801.836995968@goodmis.org>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-rt-users.vger.kernel.org

This chunk doesn't seem to belong in this patch...

diff --git a/include/linux/netdevice.h b/include/linux/netdevice.h
index 819923f..ba78526 100644
--- a/include/linux/netdevice.h
+++ b/include/linux/netdevice.h
@@ -1139,7 +1139,7 @@ struct net_device {
 	unsigned char		perm_addr[MAX_ADDR_LEN]; /* permanent hw address */
 	unsigned char		addr_assign_type; /* hw address assignment type */
 	unsigned char		addr_len;	/* hardware address length	*/
-	unsigned char		neigh_priv_len;
+	unsigned short		neigh_priv_len;
 	unsigned short          dev_id;		/* for shared network cards */
 
 	spinlock_t		addr_list_lock;
