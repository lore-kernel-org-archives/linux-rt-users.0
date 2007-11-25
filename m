From: James Stone <jamesmstone@gmail.com>
Subject: Re: bug in change from rt preempt 2.6.20 to 2.6.21? - energyxt2
	problems.
Date: Sun, 25 Nov 2007 20:17:16 +0000
Message-ID: <20071125201716.GA7806@moon.base>
References: <20071124212607.GA5510@moon.base> <20071125134138.GA26024@elte.hu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: support@xt-hq.com
To: linux-rt-users@vger.kernel.org
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from ug-out-1314.google.com ([66.249.92.175]:18282 "EHLO
	ug-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754236AbXKYURc (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Sun, 25 Nov 2007 15:17:32 -0500
Received: by ug-out-1314.google.com with SMTP id z38so794196ugc
        for <linux-rt-users@vger.kernel.org>; Sun, 25 Nov 2007 12:17:30 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <20071125134138.GA26024@elte.hu>
Sender: linux-rt-users-owner@vger.kernel.org
List-Id: linux-rt-users.vger.kernel.org

Dear all,

Ingo suggested I forward this bugreport to this list.

I found that applying the rt preempt patch to kernel 2.6.21 or
greater leads audio and midi to malfunction in the (closed
source) program energyxt2. Everything works fine with the rt
preempt patch to kernel 2.6.20 or with a vanilla 2.6.21 or
greater kernel. I would be interested if something major happened
between these two releases. I have cc'd the developer of
energyxt2 so perhaps something can be sorted out.. It may be a
problem with the way energyxt2 handles audio/midi I guess,
because all other linux audio programs seem to work fine.

Best wishes,

James
