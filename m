Return-Path: <SRS0=/7Cv=U2=vger.kernel.org=linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DA5F8C48BE4
	for <linux-rt-users@archiver.kernel.org>; Thu, 27 Jun 2019 18:00:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AF932208E3
	for <linux-rt-users@archiver.kernel.org>; Thu, 27 Jun 2019 18:00:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726543AbfF0SAN (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Thu, 27 Jun 2019 14:00:13 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:29412 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726502AbfF0SAN (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Thu, 27 Jun 2019 14:00:13 -0400
Received: from pps.filterd (m0098393.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x5RHvBbC102613
        for <linux-rt-users@vger.kernel.org>; Thu, 27 Jun 2019 14:00:12 -0400
Received: from e11.ny.us.ibm.com (e11.ny.us.ibm.com [129.33.205.201])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2td2nd85et-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-rt-users@vger.kernel.org>; Thu, 27 Jun 2019 14:00:11 -0400
Received: from localhost
        by e11.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-rt-users@vger.kernel.org> from <paulmck@linux.vnet.ibm.com>;
        Thu, 27 Jun 2019 19:00:10 +0100
Received: from b01cxnp22035.gho.pok.ibm.com (9.57.198.25)
        by e11.ny.us.ibm.com (146.89.104.198) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Thu, 27 Jun 2019 19:00:06 +0100
Received: from b01ledav003.gho.pok.ibm.com (b01ledav003.gho.pok.ibm.com [9.57.199.108])
        by b01cxnp22035.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id x5RI05xC54067698
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 27 Jun 2019 18:00:05 GMT
Received: from b01ledav003.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 377F8B2064;
        Thu, 27 Jun 2019 18:00:05 +0000 (GMT)
Received: from b01ledav003.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 242E4B206B;
        Thu, 27 Jun 2019 18:00:05 +0000 (GMT)
Received: from paulmck-ThinkPad-W541 (unknown [9.70.82.26])
        by b01ledav003.gho.pok.ibm.com (Postfix) with ESMTP;
        Thu, 27 Jun 2019 18:00:05 +0000 (GMT)
Received: by paulmck-ThinkPad-W541 (Postfix, from userid 1000)
        id 252A116C0E68; Thu, 27 Jun 2019 11:00:07 -0700 (PDT)
Date:   Thu, 27 Jun 2019 11:00:07 -0700
From:   "Paul E. McKenney" <paulmck@linux.ibm.com>
To:     Scott Wood <swood@redhat.com>
Cc:     Steven Rostedt <rostedt@goodmis.org>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Juri Lelli <juri.lelli@redhat.com>,
        Clark Williams <williams@redhat.com>,
        linux-rt-users@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [RFC PATCH RT 4/4] rcutorture: Avoid problematic critical
 section nesting
Reply-To: paulmck@linux.ibm.com
References: <20190619011908.25026-1-swood@redhat.com>
 <20190619011908.25026-5-swood@redhat.com>
 <20190620211826.GX26519@linux.ibm.com>
 <20190621163821.rm2rhsnvfo5tnjul@linutronix.de>
 <20190621235955.GK26519@linux.ibm.com>
 <20190626110847.2dfdf72c@gandalf.local.home>
 <8462f30720637ec0da377aa737d26d2cad424d36.camel@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <8462f30720637ec0da377aa737d26d2cad424d36.camel@redhat.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-TM-AS-GCONF: 00
x-cbid: 19062718-2213-0000-0000-000003A5D520
X-IBM-SpamModules-Scores: 
X-IBM-SpamModules-Versions: BY=3.00011342; HX=3.00000242; KW=3.00000007;
 PH=3.00000004; SC=3.00000286; SDB=6.01224104; UDB=6.00644247; IPR=6.01005293;
 MB=3.00027492; MTD=3.00000008; XFM=3.00000015; UTC=2019-06-27 18:00:09
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 19062718-2214-0000-0000-00005F04DBB5
Message-Id: <20190627180007.GA27126@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-06-27_12:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1810050000 definitions=main-1906270205
Sender: linux-rt-users-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org

On Wed, Jun 26, 2019 at 11:49:16AM -0500, Scott Wood wrote:
> On Wed, 2019-06-26 at 11:08 -0400, Steven Rostedt wrote:
> > On Fri, 21 Jun 2019 16:59:55 -0700
> > "Paul E. McKenney" <paulmck@linux.ibm.com> wrote:
> > 
> > > I have no objection to the outlawing of a number of these sequences in
> > > mainline, but am rather pointing out that until they really are outlawed
> > > and eliminated, rcutorture must continue to test them in mainline.
> > > Of course, an rcutorture running in -rt should avoid testing things that
> > > break -rt, including these sequences.
> > 
> > We should update lockdep to complain about these sequences. That would
> > "outlaw" them in mainline. That is, after we clean up all the current
> > sequences in the code. And we also need to get Linus's approval of this
> > as I believe he was against enforcing this in the past.
> 
> Was the opposition to prohibiting some specific sequence?  It's only certain
> misnesting scenarios that are problematic.  The rcu_read_lock/
> local_irq_disable restriction can be dropped with the IPI-to-self added in
> Paul's tree.  Are there any known instances of the other two (besides
> rcutorture)?

Given the failure scenario Sebastian Siewior reported today, there
apparently are some, at least when running threaded interrupt handlers.

							Thanx, Paul

