From: "Leon Woestenberg" <leon.woestenberg@gmail.com>
Subject: Re: 2.6.24.7-rt14
Date: Sat, 28 Jun 2008 19:13:55 +0200
Message-ID: <c384c5ea0806281013t50e56efes46ff7c53e58097ba@mail.gmail.com>
References: <1214256117.8701.13.camel@localhost.localdomain>
	 <g45dvm$pvt$1@ger.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: linux-rt-users@vger.kernel.org, linux-kernel@vger.kernel.org
To: trem <tremyfr@yahoo.fr>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from an-out-0708.google.com ([209.85.132.250]:53559 "EHLO
	an-out-0708.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752781AbYF1RN4 (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Sat, 28 Jun 2008 13:13:56 -0400
Received: by an-out-0708.google.com with SMTP id d40so191005and.103
        for <linux-rt-users@vger.kernel.org>; Sat, 28 Jun 2008 10:13:55 -0700 (PDT)
In-Reply-To: <g45dvm$pvt$1@ger.gmane.org>
Content-Disposition: inline
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

Hello,

On Sat, Jun 28, 2008 at 3:19 PM, trem <tremyfr@yahoo.fr> wrote:
> [trem@localhost rt-tests]$ sudo ./cyclictest -t 1 -p 80 -n -i 10000 -l

Just a warning to everyone, not that it affects the test or results in
case of 1 thread, but that should be -t1 instead of -t 1.

This little difference would matter if you decided to use more than 1 thread.

"-t NUM" will not pick up the NUM value, as optional arguments must
not have a space between the option and (optional) argument.

Regards,
-- 
Leon
