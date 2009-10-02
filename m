From: Oliver Neukum <oliver@neukum.org>
Subject: Re: [PATCH][UHCI-DEBUG] Don't kmalloc with BKL held
Date: Fri, 2 Oct 2009 14:01:36 +0200
Message-ID: <200910021401.37997.oliver@neukum.org>
References: <1254474744.28661.2.camel@sven.thebigcorporation.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: 7bit
Cc: LKML <linux-kernel@vger.kernel.org>,
	"linux-rt-users" <linux-rt-users@vger.kernel.org>
To: "Sven-Thorsten Dietrich" <sdietrich@novell.com>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from smtp-out003.kontent.com ([81.88.40.217]:50689 "EHLO
	smtp-out003.kontent.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753625AbZJBL7x (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Fri, 2 Oct 2009 07:59:53 -0400
In-Reply-To: <1254474744.28661.2.camel@sven.thebigcorporation.com>
Content-Disposition: inline
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

Am Freitag, 2. Oktober 2009 11:12:24 schrieb Sven-Thorsten Dietrich:
> Subject: Don't kmalloc with BKL held.
> From: Sven-Thorsten Dietrich <sdietrich@suse.de>
>
> I'm eyeballing this file for complete removal of lock_kernel but
> at first glance, we definitely don't need BKL to kmalloc().

The reasoning is correct, but this patch screws up the error case.
You also need to move the label.

	Regards
		Oliver

