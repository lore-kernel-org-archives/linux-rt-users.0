From: Richard Cochran <richardcochran@gmail.com>
Subject: Re: CLOCK_MONOTONIC issue
Date: Mon, 22 Jun 2015 13:40:23 +0200
Message-ID: <20150622114023.GB2539@netboy>
References: <5587EC34.2070808@fastwebnet.it>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: linux-rt-users@vger.kernel.org
To: Giuliano Colla <giuliano.colla@fastwebnet.it>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from mail-wg0-f52.google.com ([74.125.82.52]:36842 "EHLO
	mail-wg0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933216AbbFVLk1 (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Mon, 22 Jun 2015 07:40:27 -0400
Received: by wguu7 with SMTP id u7so66774048wgu.3
        for <linux-rt-users@vger.kernel.org>; Mon, 22 Jun 2015 04:40:26 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <5587EC34.2070808@fastwebnet.it>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

On Mon, Jun 22, 2015 at 01:06:28PM +0200, Giuliano Colla wrote:
> Using as a parameter CLOCK_REALTIME everything appears to work as expected,
> but if I attempt to use CLOCK_MONOTONIC (which should be a more reliable
> timing source, from what I read), I get bogus times.

What do you mean by "bogus times"?

Thanks,
Richard
--
To unsubscribe from this list: send the line "unsubscribe linux-rt-users" in
