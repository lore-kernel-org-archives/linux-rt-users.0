From: Frank Rowand <frank.rowand@am.sony.com>
Subject: Re: [PATCH 1/2] RFC cyclictest: clean up --latency ordering in getopt
Date: Mon, 7 May 2012 15:00:17 -0700
Message-ID: <4FA845F1.4080205@am.sony.com>
References: <4FA841B4.20701@am.sony.com> <4FA842F3.60204@am.sony.com>
Reply-To: <frank.rowand@am.sony.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 7bit
Cc: "linux-rt-users@vger.kernel.org" <linux-rt-users@vger.kernel.org>,
	"williams@redhat.com" <williams@redhat.com>,
	"jkacur@redhat.com" <jkacur@redhat.com>,
	"dvhart@linux.intel.com" <dvhart@linux.intel.com>
To: "Rowand, Frank" <Frank_Rowand@sonyusa.com>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from tx2ehsobe004.messaging.microsoft.com ([65.55.88.14]:15044 "EHLO
	tx2outboundpool.messaging.microsoft.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1750998Ab2EGWAv (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Mon, 7 May 2012 18:00:51 -0400
In-Reply-To: <4FA842F3.60204@am.sony.com>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

This is the resulting message on the ARM panda with a 'bad'
32khz timer:


  # cyclictest -q -p 80 -t -n -l 10 -h ${hist_bins} -R 100
  reported clock resolution: 1 nsec
  measured clock resolution less than: 30517 nsec


A possible follow on patch would be to generate a hard
error (fail the test) if the measured resolution was
above some unreasonable value (perhaps > 1 msec), but
allow the hard fail to be overridden with yet another
command line option.  Any opinions about that?

-Frank

