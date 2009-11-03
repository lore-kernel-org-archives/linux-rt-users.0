From: Thomas Gleixner <tglx@linutronix.de>
Subject: Re: [PATCH -rt]
 Updates-from-Jon-Masters-for-hwlat_detector.c.patch
Date: Tue, 3 Nov 2009 14:15:28 +0100 (CET)
Message-ID: <alpine.LFD.2.00.0911031413230.12138@localhost.localdomain>
References: <alpine.LFD.2.00.0910230007030.3737@localhost.localdomain>  <alpine.LFD.2.00.0911021620580.12138@localhost.localdomain> <520f0cf10911021146i136af7bfg370a217185b5154c@mail.gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: linux-kernel@vger.kernel.org, Jon Masters <jcm@redhat.com>,
	linux-rt-users@vger.kernel.org,
	Clark Williams <williams@redhat.com>
To: John Kacur <jkacur@redhat.com>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from www.tglx.de ([62.245.132.106]:34725 "EHLO www.tglx.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753154AbZKCNPo (ORCPT <rfc822;linux-rt-users@vger.kernel.org>);
	Tue, 3 Nov 2009 08:15:44 -0500
In-Reply-To: <520f0cf10911021146i136af7bfg370a217185b5154c@mail.gmail.com>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

On Mon, 2 Nov 2009, John Kacur wrote:
> Updated patch just adds the error checking from Jon Masters then,
> patched against -rt.

Can you please inline patches ?

@@ -607,7 +607,11 @@ static ssize_t  debug_enable_fwrite(stru
 		if (!enabled)
 			goto unlock;
 		enabled = 0;
-		stop_kthread();
+		err = stop_kthread();
+		if (0 != err) {

	Eeew !	

Thanks,

	tglx
