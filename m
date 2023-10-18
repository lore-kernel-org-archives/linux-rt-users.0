Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 326203AC2D
	for <linux-rt-users@vger.kernel.org>; Wed, 18 Oct 2023 15:34:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dkim=none
Received: from netrider.rowland.org (netrider.rowland.org [192.131.102.5])
	by lindbergh.monkeyblade.net (Postfix) with SMTP id 5FDE811C
	for <linux-rt-users@vger.kernel.org>; Wed, 18 Oct 2023 08:34:32 -0700 (PDT)
Received: (qmail 224806 invoked by uid 1000); 18 Oct 2023 11:34:31 -0400
Date: Wed, 18 Oct 2023 11:34:31 -0400
From: Alan Stern <stern@rowland.harvard.edu>
To: "Li, Meng" <Meng.Li@windriver.com>
Cc: Steven Rostedt <rostedt@goodmis.org>, Ingo Molnar <mingo@redhat.com>,
  USB mailing list <linux-usb@vger.kernel.org>,
  Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
  linux-rt-users <linux-rt-users@vger.kernel.org>
Subject: Re: USB: add check to detect host controller hardware removal
Message-ID: <1c3d5ac3-0a92-4f5e-a30c-099a8f8ba94d@rowland.harvard.edu>
References: <PH0PR11MB5191464B2F01511D2ADECB3BF1D2A@PH0PR11MB5191.namprd11.prod.outlook.com>
 <9a1074e2-c1ae-485b-b5e7-a34442c98c0b@rowland.harvard.edu>
 <20231016125624.1096766a@gandalf.local.home>
 <62fdcf97-11c6-4dee-8db1-74752d6949f3@rowland.harvard.edu>
 <PH0PR11MB5191924ECC92A8F67891D614F1D6A@PH0PR11MB5191.namprd11.prod.outlook.com>
 <d6d9478c-585b-4f51-a076-dc2955c6b2b0@rowland.harvard.edu>
 <PH0PR11MB51911132F6CB7DF0C41F15DEF1D5A@PH0PR11MB5191.namprd11.prod.outlook.com>
 <1f8fe9f9-d8d6-48d9-8c7d-1215d10ece91@rowland.harvard.edu>
Precedence: bulk
X-Mailing-List: linux-rt-users@vger.kernel.org
List-Id: <linux-rt-users.vger.kernel.org>
List-Subscribe: <mailto:linux-rt-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rt-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1f8fe9f9-d8d6-48d9-8c7d-1215d10ece91@rowland.harvard.edu>
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_PASS,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Wed, Oct 18, 2023 at 11:20:46AM -0400, Alan Stern wrote:
> On Wed, Oct 18, 2023 at 05:00:58AM +0000, Li, Meng wrote:
> > > Were you able to locate the original bug report?
> > > 
> > This is original bug report
> > https://bugzilla.redhat.com/show_bug.cgi?id=579093
> 
> The Red Hat Bugzilla says:
> 
> 	You are not authorized to access bug #579093.
> 
> So I can't tell exactly what happened back then.  :-(
> 
> But I do vaguely remember the discussion with Stratus Technologies.  
> They had special hardware in their systems, which allowed them to do 
> hot-swapping of PCI components.

Incidentally, for anyone who's interested, some early discussion about 
these problems can be found on an open mailing list here:

	https://marc.info/?l=linux-usb&m=127559364101206&w=2

Alan Stern
