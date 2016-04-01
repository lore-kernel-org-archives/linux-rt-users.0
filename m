From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Subject: Re: [PATCH] list_bl: fixup bogus lockdep warning
Date: Fri, 1 Apr 2016 12:46:33 +0200
Message-ID: <20160401104632.GC29603@linutronix.de>
References: <56FB8B5A.8@linutronix.de>
 <1459400665-12546-1-git-send-email-joshc@ni.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: linux-rt-users@vger.kernel.org,
	Thomas Gleixner <tglx@linutronix.de>,
	"Luis Claudio R. Goncalves" <lclaudio@uudg.org>
To: Josh Cartwright <joshc@ni.com>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from www.linutronix.de ([62.245.132.108]:53016 "EHLO
	Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752322AbcDAKqg convert rfc822-to-8bit (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Fri, 1 Apr 2016 06:46:36 -0400
Content-Disposition: inline
In-Reply-To: <1459400665-12546-1-git-send-email-joshc@ni.com>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

* Josh Cartwright | 2016-03-31 00:04:25 [-0500]:

>At first glance, the use of 'static inline' seems appropriate for
>INIT_HLIST_BL_HEAD().
=E2=80=A6
>
>Reported-by: Luis Claudio R. Goncalves <lclaudio@uudg.org>
>Tested-by: Luis Claudio R. Goncalves <lclaudio@uudg.org>
>Signed-off-by: Josh Cartwright <joshc@ni.com>

Applied, thanks.

Sebastian
--
To unsubscribe from this list: send the line "unsubscribe linux-rt-user=
s" in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
