From: Udo van den Heuvel <udovdh@xs4all.nl>
Subject: Re: newer rt-kernel?
Date: Sun, 12 Jun 2011 05:28:55 +0200
Message-ID: <4DF43277.7040303@xs4all.nl>
References: <4DF343B1.5030303@xs4all.nl> <BANLkTinbjh4SuODRqR0sQtE1y-G-sNmQiQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: RT <linux-rt-users@vger.kernel.org>
To: Mark Knecht <markknecht@gmail.com>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from pindarots.xs4all.nl ([80.101.128.228]:36218 "EHLO
	pindarots.xs4all.nl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750876Ab1FLD3A (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Sat, 11 Jun 2011 23:29:00 -0400
In-Reply-To: <BANLkTinbjh4SuODRqR0sQtE1y-G-sNmQiQ@mail.gmail.com>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

On 2011-06-11 20:00, Mark Knecht wrote:
>> So how can we fix or at least circumvent this?
>>
> There is, unfortunately, nothing newer.
> 
> Use  2.6.33.9-rt31 or try a newer, non-rt kernel and hope for good results.

2.6.39.1 has forced threaded interrupts and appears to work.

Kind regards,
Udo

