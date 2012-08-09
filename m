From: Frank Rowand <frank.rowand@am.sony.com>
Subject: [RFC] looking for feedback on stable RT patch process
Date: Wed, 8 Aug 2012 17:38:01 -0700
Message-ID: <50230669.2070501@am.sony.com>
Reply-To: <frank.rowand@am.sony.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 7bit
To: RT <linux-rt-users@vger.kernel.org>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from ch1ehsobe003.messaging.microsoft.com ([216.32.181.183]:12361
	"EHLO ch1outboundpool.messaging.microsoft.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1758675Ab2HIAii (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Wed, 8 Aug 2012 20:38:38 -0400
Received: from mail146-ch1 (localhost [127.0.0.1])	by
 mail146-ch1-R.bigfish.com (Postfix) with ESMTP id 07263100381	for
 <linux-rt-users@vger.kernel.org>; Thu,  9 Aug 2012 00:38:37 +0000 (UTC)
Received: from CH1EHSMHS005.bigfish.com (snatpool2.int.messaging.microsoft.com
 [10.43.68.235])	by mail146-ch1.bigfish.com (Postfix) with ESMTP id
 2669B2A005F	for <linux-rt-users@vger.kernel.org>; Thu,  9 Aug 2012 00:38:36
 +0000 (UTC)
Received: from usculsndmail13v.am.sony.com (usculsndmail13v.am.sony.com
 [146.215.230.104])	by usculsndmail04v.am.sony.com
 (Sentrion-MTA-4.2.2/Sentrion-MTA-4.2.2) with ESMTP id q790cYx8017847
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=FAIL)	for
 <linux-rt-users@vger.kernel.org>; Thu, 9 Aug 2012 00:38:35 GMT
Received: from mail1x.sjc.in.sel.sony.com (mailx.bc.in.sel.sony.com
 [43.134.1.112])	by usculsndmail13v.am.sony.com
 (Sentrion-MTA-4.2.2/Sentrion-MTA-4.2.2) with ESMTP id q790cXlG005296
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=FAIL)	for
 <linux-rt-users@vger.kernel.org>; Thu, 9 Aug 2012 00:38:34 GMT
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

Hi All,

I'm going to be giving a presentation at Plumbers on the RT stable
patch process and I would like for it to reflect more than just
my personal experiences and biases.  If you have opinions and
experiences, please email me directly (please do not reply
to the list - I will send a summary to the list after Plumbers).

If you have any additional questions that you think would be
interesting, please post them to the list as a reply to this message.

Please answer any or all of the following questions:

 1) Have you downloaded any stable RT releases?  If so, approximately how many?
    If not, why not?

 2) How do you use the stable RT release?  To run on a single system?  To place
    on a product that is sold / lent / given away?  To create a distribution?
    Other?

 3) Is the stable RT release useful and valuable?  (How many beers do we owe
    to Steve when we run into him at conferences?)  Why is it useful and
    valuable?

 4) If the stable RT release is not useful, why isn't it?

 5) What changes would make the RT release more useful?  Why would the changes
    make it more useful?

 6) What changes would make the RT release better?

 7) What should _not_ change about the stable RT release?

 8) How frequently do you test a stable RT release (percent of releases)?

 9) How intensively do you test a stable RT release?  Boot?  Functional test?
    Performance test(s)?  Other test(s)?  Single target (type of computer)?
    Multiple targets?  How many different types of targets?

10) Which series have been useful?  Which series is currently most useful (can
    be more than one)?  (3.0.x, 3.2.x, 3.4.x)

11) Any other random or useful comments or opinions?


Thanks for any and all input!

-Frank

