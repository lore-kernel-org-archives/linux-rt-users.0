From: Rui Nuno Capela <rncbc@rncbc.org>
Subject: 2.6.21-rc5-rt10 troubles
Date: Wed, 04 Apr 2007 00:49:23 +0100
Message-ID: <4612E803.8070600@rncbc.org>
References: <23932.213.58.131.130.1170156409.squirrel@www.rncbc.org> <460FE7F3.4060303@rncbc.org> <20070401183928.GB27614@elte.hu>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: linux-kernel@vger.kernel.org, linux-rt-users@vger.kernel.org
To: Ingo Molnar <mingo@elte.hu>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from smtpa1.netcabo.pt ([212.113.174.16]:19269 "EHLO
	exch01smtp03.hdi.tvcabo" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1030275AbXDCXtO (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Tue, 3 Apr 2007 19:49:14 -0400
In-Reply-To: <20070401183928.GB27614@elte.hu>
Sender: linux-rt-users-owner@vger.kernel.org
List-Id: linux-rt-users.vger.kernel.org

Ingo et al.

I'm afraid having no good news (once again). After building
2.6.21-rc5-rt8 and recently on -rt10 I've found some trouble running on
a Core2 T7200 laptop (SMP). Somehow, specially after starting jackd, the
whole system starts crawling to death. It just slows down to some kind
of Big Freeze, with no evidence over the console whatsoever, so that I'm
ultimately left with a brick on my hands.

This behavior is consistent and occurs every time after jackd is
started. It does not seem to occur on -rt5 and earlier.

I wish I could give you more details, but fact is I don't know where to
look. The machine just freezes silently.

Bye now.
-- 
rncbc aka Rui Nuno Capela
rncbc@rncbc.org
