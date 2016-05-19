From: Brad Hughes <brad28b@gmail.com>
Subject: Wrong time displayed on date/time selector custom field
Date: Thu, 19 May 2016 10:30:13 +1000
Message-ID: <CA+swKTg17fh71oAZEZWcrmZKU+o35ZjAQRj5WsXH=WUUSGe+CQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
To: linux-rt-users@vger.kernel.org
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from mail-io0-f180.google.com ([209.85.223.180]:34259 "EHLO
	mail-io0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752175AbcESAaO (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Wed, 18 May 2016 20:30:14 -0400
Received: by mail-io0-f180.google.com with SMTP id 190so87201886iow.1
        for <linux-rt-users@vger.kernel.org>; Wed, 18 May 2016 17:30:13 -0700 (PDT)
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

Hi All,

We are using RT 4.2.8 and we have recently started using custom fields
that are date time selectors (ie. they pop up a calendar where you can
select a date and time).

We have encountered a problem where the value in the custom field is
being displayed wrong.

What I believe is happening is that when the date time custom field is
populated with a date/time, that is being stored in RT's mysql
database in local time format. Where as every other time in RTs mysql
database seems to be stored in UTC or GMT time format.

When the RT GUI displays the time stored in custom field of the
date/time selector, it is assuming that it is a UTC or GMT format, and
it's attempting to convert it to local time - which makes it display
incorrect in the RT GUI.

Has anyone encountered this problem and if so what did you do to get around it?

Thank you,

Brad Hughes
