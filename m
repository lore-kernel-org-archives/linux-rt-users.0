From: Andi Kleen <andi@firstfloor.org>
Subject: Re: [PATCH] kexec: reenable HPET before kexec
Date: 20 Aug 2007 20:26:38 +0200
Message-ID: <p73tzquysdd.fsf@bingen.suse.de>
References: <20070820205530.1ffd5876@windmill.dev.rtsoft.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: RT <linux-rt-users@vger.kernel.org>,
	linux-kernel <linux-kernel@vger.kernel.org>
To: Konstantin Baydarov <kbaidarov@ru.mvista.com>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from mx2.suse.de ([195.135.220.15]:33704 "EHLO mx2.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755322AbXHTRcx (ORCPT <rfc822;linux-rt-users@vger.kernel.org>);
	Mon, 20 Aug 2007 13:32:53 -0400
In-Reply-To: <20070820205530.1ffd5876@windmill.dev.rtsoft.ru>
Sender: linux-rt-users-owner@vger.kernel.org
List-Id: linux-rt-users.vger.kernel.org

Konstantin Baydarov <kbaidarov@ru.mvista.com> writes:

> Hi, I've faced problem:
> I have two x86_64 kernels with HPET enabled:

Is this for a standard kernel or for a RT kernel?

-Andi
