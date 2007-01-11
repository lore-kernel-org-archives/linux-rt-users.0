From: Robert Schwebel <r.schwebel@pengutronix.de>
Subject: Re: Plotting the output of cyclictest?
Date: Thu, 11 Jan 2007 13:00:33 +0100
Message-ID: <20070111120033.GH29495@pengutronix.de>
References: <45A61B96.3070505@imc-berlin.de>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="8GpibOaaTibBMecb"
Cc: linux-rt-users@vger.kernel.org
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from metis.extern.pengutronix.de ([83.236.181.26]:46344 "EHLO
	metis.extern.pengutronix.de" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1030286AbXAKMAd (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Thu, 11 Jan 2007 07:00:33 -0500
To: Steven Scholz <steven.scholz@imc-berlin.de>
Content-Disposition: inline
In-Reply-To: <45A61B96.3070505@imc-berlin.de>
Sender: linux-rt-users-owner@vger.kernel.org
List-Id: linux-rt-users.vger.kernel.org


--8GpibOaaTibBMecb
Content-Type: text/plain; charset=iso-8859-15
Content-Disposition: inline

On Thu, Jan 11, 2007 at 12:12:22PM +0100, Steven Scholz wrote:
> are there some nice scripts out there that will generate neat plots
> from the output of cyclictest?

Attached. Sorry for the lazyness of not putting it on some webpage...

Robert
-- 
 Dipl.-Ing. Robert Schwebel | http://www.pengutronix.de
 Pengutronix - Linux Solutions for Science and Industry
   Handelsregister:  Amtsgericht Hildesheim, HRA 2686
     Hannoversche Str. 2, 31134 Hildesheim, Germany
   Phone: +49-5121-206917-0 |  Fax: +49-5121-206917-9


--8GpibOaaTibBMecb
Content-Type: application/x-sh
Content-Disposition: attachment; filename="make_hist.sh"
Content-Transfer-Encoding: quoted-printable

#!/bin/bash=0A=0A#=0A# Copyright (C) 2006 Luotao Fu, Pengutronix (lfu@pengu=
tronix.de)=0A#=0A# parse the output file of cyclictest in debug mode in plo=
ttable histogramm=0A# files, single files are automatically created on dete=
cting new threads.=0A#=0A=0Aset -e=0A=0Aargs=3D$(getopt i: $*)=0A=0Aif [ $?=
 -ne 0 ] || [ $# -eq 0 ];then=0A    echo "Usage: $(basename $0) -i inputfil=
e"=0A    exit 1=0Afi=0Afor i in $args; do=0A    case "$i" in=0A	-i) shift;l=
ogfile_name=3D$(basename $1);;=0A    esac=0Adone=0A=0Alogfile_name_prefix=
=3D$(echo $logfile_name | cut -d . -f 1)=0Astep_dist=3D2=0Athread_sum=3D0=
=0Astep_counter=3D0=0A=0AIFS_BUF=3D$IFS=0AIFS=3D"$IFS:"=0A=0Aecho -n "split=
ting single thread logs"=0A=0A=0Awhile read thread_nr loop_count m_result ;=
do=0A    echo "${loop_count} ${m_result}" >> ${logfile_name_prefix}_plot_th=
read${thread_nr}".log"=0A    #determine thread summary and search for min, =
max=0A    if [ ${loop_count} -eq 0 ];then=0A	if [ ! $thread_nr ] || [ ! $lo=
op_count ] || [ ! $m_result ];then=0A	    echo "parsing failed, check your =
input file"=0A	    exit 1=0A	fi=0A	(( thread_sum++ ))=0A	if [ -e ${logfile_=
name_prefix}_plot_thread${thread_nr}".log" ] ; then=0A	    rm ${logfile_nam=
e_prefix}_plot_thread${thread_nr}".log"=0A	fi=0A    elif [ $loop_count -eq =
1 ];then=0A	max[thread_nr]=3D${m_result}=0A	min[thread_nr]=3D${m_result}=0A=
    else=0A	if [ ${m_result} -gt ${max[thread_nr]} ];then=0A	    max[thread=
_nr]=3D${m_result}=0A	elif [ ${m_result} -lt ${min[thread_nr]} ];then=0A	  =
  min[thread_nr]=3D${m_result}=0A	fi=0A    fi=0A=0A    #now try to collect =
histogram data=0A    if [ $loop_count -ne 0 ];then=0A	hist_index=3D$(( ${m_=
result}/${step_dist} ))=0A	tmp_name=3Dhist_data_${thread_nr}[$hist_index]=
=0A	tmp_val=3D${!tmp_name}=0A	(( tmp_val++ ))=0A	eval ${tmp_name}=3D${tmp_v=
al}=0A    fi=0A=0A    #we'd give the user some lifesign every 5000 lines=0A=
    if [ $(( ${loop_count} / 5000 )) -ge $step_counter ]; then=0A	echo -n "=
=2E"=0A	(( step_counter++ ))=0A    fi=0Adone < $1=0Aecho done=0A=0A=0Aecho =
-n "making histogram files"=0A=0A=0Afor ((thr_co=3D0; thr_co < thread_sum ;=
 thr_co++)); do=0A    echo -n "."=0A    hist_array=3Dhist_data_${thr_co}[@]=
=0A    hist_index=3D0;=0A    if [ -e ${logfile_name_prefix}_hist_thread${th=
r_co}".log" ]; then=0A	rm ${logfile_name_prefix}_hist_thread${thr_co}".log"=
=0A    fi=0A    for value in ${!hist_array}; do=0A	index_value=3D$((${hist_=
index} * ${step_dist}))=0A	echo "$index_value $value" >> ${logfile_name_pre=
fix}_hist_thread${thr_co}".log"=0A	(( hist_index++ ))=0A    done=0Adone=0A=
=0A=0Aecho done=0A=0AIFS=3D$IFS_BUF=0A
--8GpibOaaTibBMecb--
