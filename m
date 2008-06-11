From: "Leon Woestenberg" <leon.woestenberg@gmail.com>
Subject: Re: cyclictest - trouble explaning results
Date: Wed, 11 Jun 2008 21:09:52 +0200
Message-ID: <c384c5ea0806111209o673037b0o27578de171815f6a@mail.gmail.com>
References: <20080611151437.234900@gmx.net>
	 <c384c5ea0806111208s375232c7y6209238ebf1d167f@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: linux-rt-users@vger.kernel.org
To: "Oleg Galimov" <Galimov@gmx.de>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from rv-out-0506.google.com ([209.85.198.229]:10237 "EHLO
	rv-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751501AbYFKTJy (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Wed, 11 Jun 2008 15:09:54 -0400
Received: by rv-out-0506.google.com with SMTP id k40so1612617rvb.1
        for <linux-rt-users@vger.kernel.org>; Wed, 11 Jun 2008 12:09:52 -0700 (PDT)
In-Reply-To: <c384c5ea0806111208s375232c7y6209238ebf1d167f@mail.gmail.com>
Content-Disposition: inline
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

Hello,

On Wed, Jun 11, 2008 at 9:08 PM, Leon Woestenberg
<leon.woestenberg@gmail.com> wrote:
> Possibly, without the single-threaded 'time hog', your cyclictest
> threads maybe are scheduled across the two cores, resulting in
>
stated more correctly: ...each of your cyclictest threads may be
migrated between cores...

-- 
Leon
