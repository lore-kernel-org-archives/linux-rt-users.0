From: "George C. Huntington, III" <george.huntingtoniii@gmail.com>
Subject: USB ethernet and USB WIFI
Date: Wed, 27 Jun 2012 09:08:56 -0400
Message-ID: <CAFu+nvEmetwKSY8Mxi35cTb_WKC29EDisWsUcmPmvFYajjM0tg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
To: linux-rt-users@vger.kernel.org
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from mail-vc0-f174.google.com ([209.85.220.174]:36725 "EHLO
	mail-vc0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750811Ab2F0NI5 (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Wed, 27 Jun 2012 09:08:57 -0400
Received: by vcbf11 with SMTP id f11so666557vcb.19
        for <linux-rt-users@vger.kernel.org>; Wed, 27 Jun 2012 06:08:56 -0700 (PDT)
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

I have been having a bear of a time getting USB WIFI dongles to work
with the realtime kernel.  I have been working with a 2.6.33 kernel.

The drivers seems to work, but never actually connect to a network or
allow traffic to pass through them.  out of desperation I also tried a
usb to ethernet dongle, but it wouldn't connect to the network either.
 Is there some known problem or reason why this might not work on the
realtime kernel?

any help or info is greatly appreciated!
thanks,
-george
