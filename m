From: Nicholas Mc Guire <der.herr@hofr.at>
Subject: Re: I/O operations priority in RTOS
Date: Mon, 6 Jun 2011 02:21:42 +0200
Message-ID: <20110606002142.GA32539@opentech.at>
References: <4DEA1BA9.7020303@unican.es> <4DEA1F22.6000603@unican.es> <20110604234214.GA30640@opentech.at> <4DEB427F.9020104@steinhoff.de> <20110605092854.GA7576@opentech.at> <4DEB5015.7070601@web.de> <20110605222954.GA13340@opentech.at> <4DEC0A7F.7090207@web.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Armin Steinhoff <armin@steinhoff.de>,
	Monica Puig-Pey <puigpeym@unican.es>,
	linux-rt-users@vger.kernel.org
To: Jan Kiszka <jan.kiszka@web.de>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from hofr.at ([212.69.189.236]:41629 "EHLO mail.hofr.at"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753075Ab1FFAVo (ORCPT <rfc822;linux-rt-users@vger.kernel.org>);
	Sun, 5 Jun 2011 20:21:44 -0400
Content-Disposition: inline
In-Reply-To: <4DEC0A7F.7090207@web.de>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

> 
> There are good examples - in the RT domain - for both models. Sharing a
> device does not necessarily mean making things dynamic or even
> unpredictable.
> 

then I maybe dont get the "exclusive" issue you note - if the highest priority task does not have exclusive access - assuming that there is not contention free sharing - how can you give guarantees ? I can imagin sharing if the highest priority has unconstraint access to the reource and any other access is controled by the highest priority task (i.e. queue replication like ARINC 653 queueing ports) but if you have multiple instances of different priority accessing a resource I don't see how this could be done while giving guarantees on timing (assuming that it is not possible to provide all access as physically atomic instructions)

Do you have an example at hand of such a shared I/O device scheme that can guarantee rt timing ?

> > 
> > Any pointers to VFIO ?
> 
> E.g. http://thread.gmane.org/gmane.linux.kernel.pci/10088
>
thanks. 

hofrat
