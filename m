From: Frank Rowand <frank.rowand@am.sony.com>
Subject: script to create broken out patch series from stable RT trees
Date: Mon, 4 Jun 2012 19:18:36 -0700
Message-ID: <4FCD6C7C.9090501@am.sony.com>
Reply-To: <frank.rowand@am.sony.com>
Mime-Version: 1.0
Content-Type: multipart/mixed;
	boundary="------------000008030500080102060209"
Cc: <linux-rt-users@vger.kernel.org>
To: Steven Rostedt <rostedt@goodmis.org>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from db3ehsobe006.messaging.microsoft.com ([213.199.154.144]:33529
	"EHLO db3outboundpool.messaging.microsoft.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1757857Ab2FECTD (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Mon, 4 Jun 2012 22:19:03 -0400
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

--------------000008030500080102060209
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 7bit

Steve,

I finally got around to automating my manual process of creating
a broken out set of patch files for the stable RT releases.

I'm attaching the scripts in case others might find them helpful.

-Frank

--------------000008030500080102060209
Content-Type: text/plain; name="extract_stable_patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment; filename="extract_stable_patch"

#! /bin/bash

# creating a broken out RT patch set


#-----  process script arguments

def_root_patch_path="../patches"
root_patch_path="${def_root_patch_path}"

def_tar_path="../tar"
tar_path="${def_tar_path}"

verbose=0

old_argc=0
while [[ ($# != ${old_argc}) && ($# > 0) ]] ; do
	old_argc=$#
	case $1 in
		-h | -help | --help )
			shift $# ;;
		--pp )
			root_patch_path=$2
			shift 2;;
		--tp )
			tar_path=$2
			shift 2;;
		-v | --verbose )
			verbose=1
			shift ;;
	esac
done

if (( ($# < 1) || ($# > 1) )) ; then
	echo ""                                                                   >&2
	echo "usage: `basename $0` RT_KERNEL_VERSION"                             >&2
	echo "            -h                    print this usage text"            >&2
	echo "            -help                 synonym for -h"                   >&2
	echo "           --help                 synonym for -h"                   >&2
	echo "           --pp ROOT_PATCH_PATH   path to create patch dir at"      >&2
	echo "           --tp TAR_PATH          path to create tar at"            >&2
	echo "            -v                    verbose output"                   >&2
	echo "            -verbose              synonym for -v"                   >&2
	echo "           --verbose              synonym for -v"                   >&2
	echo ""                                                                   >&2
	echo "           default ROOT_PATCH_PATH is ${def_root_patch_path}"       >&2
	echo "           default TAR_PATH is ${def_tar_path}"                     >&2
	echo ""                                                                   >&2
	echo "   examples:"                                                       >&2
	echo "       3.0.12-rt29:    `basename $0` 3.0.12-rt29"                   >&2
	echo "       3.0.32-rt52:    `basename $0` 3.0.32-rt52"                   >&2
	echo ""                                                                   >&2
	echo ""                                                                   >&2

	echo "If you do not have a local copy of the stable RT git tree, clone it"           >&2
	echo ""                                                                              >&2
	echo "  If firewall prevents using the git protocol:"                                >&2
	echo "    git clone \\"                                                              >&2
	echo "      https://git.kernel.org/pub/scm/linux/kernel/git/rt/linux-stable-rt.git"  >&2
	echo ""                                                                              >&2
	echo "  If no firewall in the way:"                                                  >&2
	echo "    git clone \\"                                                              >&2
	echo "      git://git.kernel.org/pub/scm/linux/kernel/git/rt/linux-stable-rt.git"    >&2

	echo ""                                                                   >&2
	exit 1
fi


# regex can handle x.x-rtx or x.x.x-rtx
# \1 is x.x
# \2 is    .x
# \3 is      -rtx

base_version=`echo $1 | sed -r -e 's|([0-9]+\.[0-9]+)(\.[0-9]+)*(-rt.*)|\1\2|'`
rt_version=`  echo $1 | sed -r -e 's|([0-9]+\.[0-9]+)(\.[0-9]+)*(-rt.*)|\3|'`

full_version=${base_version}${rt_version}

patch_dir="patches_${full_version}"
patch_path=${root_patch_path}/${patch_dir}


#-----  error checks

expected_cur_dir="linux-stable-rt"
cur_dir=`basename $PWD`
if [[ "${cur_dir}" != "${expected_cur_dir}" || ! -d .git ]] ; then
	echo ""                                                                   >&2
	echo "ERROR:"                                                             >&2
	echo "  Current directory does not appear to be the stable RT git tree"   >&2
	echo "  Expect current directory to be: ${expected_cur_dir}"              >&2
	echo "  Expect current directory to contain directory: .git"              >&2
	echo ""                                                                   >&2
	exit 1
fi


if [[ ! -d ${root_patch_path} ]] ; then
	echo ""                                                                   >&2
	echo "ERROR:"                                                             >&2
	echo "  Root patch directory ${root_patch_path} does not exist"           >&2
	echo ""                                                                   >&2
	exit 1
fi


if [[ ! -d ${tar_path} ]] ; then
	echo ""                                                                   >&2
	echo "ERROR:"                                                             >&2
	echo "  Tar directory ${tar_path} does not exist"                         >&2
	echo ""                                                                   >&2
	exit 1
fi


if [[ -d ${patch_path} ]] ; then
	echo ""                                                                   >&2
	echo "ERROR:"                                                             >&2
	echo "  patch directory ${patch_path} already exists"                     >&2
	echo ""                                                                   >&2
	exit 1
fi


cur_branch=`git branch | grep master`
if [[ "${cur_branch}" != '* master' ]] ; then
	echo ""                                                                   >&2
	echo "ERROR:"                                                             >&2
	echo "  current branch is not master"                                     >&2
	echo "  Consider fixing by: 'git checkout master'"                        >&2
	echo ""                                                                   >&2
	exit 1
fi


tag_full='git tag -l v${full_version}-rebase'
tag_base='git tag -l v${base_version}'

if [[ "${tag_full}" == "" || "${tag_base}" == "" ]] ; then
	echo ""                                                                   >&2
	echo "ERROR:"                                                             >&2
	echo "  Required git tags are missing"                                    >&2
	echo "  The required tags are:"                                           >&2
	echo "    ${tag_full}"                                                    >&2
	echo "    ${tag_base}"                                                    >&2
	echo ""                                                                   >&2
	echo "  'git pull' _might_ fix the problem"                               >&2
	echo ""                                                                   >&2
	echo "  This may also be an error in the master git repository"           >&2
	echo ""                                                                   >&2
	echo "  If 'git pull' does not fix the problem, deleting the repository'" >&2
	echo "  and re-cloning it _might_ fix the problem"                        >&2
	echo ""                                                                   >&2
	exit 1
fi


if [[ "${verbose}" == "1" ]] ; then
	echo ""                                                                   >&2
	echo "-----  versions:"                                                   >&2
	echo ""                                                                   >&2
	echo "  base_version  : ${base_version}"                                  >&2
	echo "  full_version  : ${full_version}"                                  >&2
	echo ""                                                                   >&2
	echo ""                                                                   >&2
	echo "-----  should see two tags: v${full_version}-rebase, v${base_version}" >&2
	echo ""                                                                   >&2
	echo -n "  "                                                              >&2
	  git tag -l v${full_version}-rebase                                      >&2
	echo -n "  "                                                              >&2
	  git tag -l v${base_version}                                             >&2
	echo ""                                                                   >&2
	echo ""                                                                   >&2
	echo "-----  other:"                                                      >&2
	echo ""                                                                   >&2
	echo "  patch_path    : ${patch_path}"                                    >&2
	echo ""                                                                   >&2
fi


#-----  checkout the rebase branch

# after checkout, will be on '* (no branch)'

if [[ "${verbose}" == "1" ]] ; then
	echo ""                                                                   >&2
	git branch                                                                >&2
	echo ""                                                                   >&2
fi

git checkout v${full_version}-rebase  > /dev/null 2> /dev/null

if [[ "$?" == "1" ]] ; then
	echo ""                                                                   >&2
	echo "ERROR:"                                                             >&2
	echo "  Unable to checkout rebase branch"                                 >&2
	echo ""                                                                   >&2
	exit 1
fi

if [[ "${verbose}" == "1" ]] ; then
	echo ""                                                                   >&2
	git branch                                                                >&2
	echo ""                                                                   >&2
fi

cur_branch=`git branch | head -n1`
if [[ "${cur_branch}" != '* (no branch)' ]] ; then
	echo ""                                                                   >&2
	echo "ERROR:"                                                             >&2
	echo "  checkout of branch v${full_version}-rebase failed"                >&2
	echo ""                                                                   >&2
fi



#-----  create the patch files in the patch directory

if [[ "${verbose}" == "1" ]] ; then
	echo ""                                                                   >&2
	echo "creating patch files in ${patch_path}"                              >&2
	echo ""                                                                   >&2
fi

git format-patch -o ${patch_path} v${base_version}  >/dev/null

if [[ "$?" == "1" ]] ; then
	echo ""                                                                   >&2
	echo "ERROR:"                                                             >&2
	echo "  Failed command:"                                                  >&2
	echo "    git format-patch -o ${patch_path} v${base_version}"             >&2
	echo ""                                                                   >&2
	exit 1
fi


#====================
cd ${patch_path}
#====================

#-----  create the series file, rename patch file names

# being careful, check for unexpected series file, before creating it

if [[ -a series ]] ; then
	echo ""                                                                   >&2
	echo "ERROR:"                                                             >&2
	echo "  Unexpected file or directory 'series' in ${patch_path}"           >&2
	echo ""                                                                   >&2
	exit 1
fi

# Create the series file.  Rename the patches to remove the numeric prefix
# in the file name so that the names of patch files will be consistent in
# different patch versions.

files_new=`mktemp`
files_old=`mktemp`
mv_files=`mktemp`

ls -1                 > ${files_old}
sed -e 's|^[0-9]*-||'   ${files_old} >${files_new}

paste -d" " ${files_old} ${files_new} | sed -e 's|^|mv |' > ${mv_files}

mv ${files_new} series

. ${mv_files}

# renamed to be series, do not need to remove
# rm ${files_new}

rm ${files_old}
rm ${mv_files}


#====================
cd -    >/dev/null
#====================


#-----  create the patch tar

tar_file_name="${tar_path}/patches-${full_version}.tar.bz2"

if [[ "${verbose}" == "1" ]] ; then
	echo ""                                                                   >&2
	echo "creating ${tar_file_name}"                                          >&2
	echo ""                                                                   >&2
fi

tar \
	-cjf ${tar_file_name} \
	--transform s/patches_${full_version}/patches/ \
	-C ${root_patch_path} \
	${patch_dir}


#-----  move back to the master branch in the git tree

if [[ "${verbose}" == "1" ]] ; then
	echo ""                                                                   >&2
	git branch                                                                >&2
	echo ""                                                                   >&2
fi

git checkout master  > /dev/null 2> /dev/null

if [[ "$?" == "1" ]] ; then
	echo ""                                                                   >&2
	echo "ERROR:"                                                             >&2
	echo "  Unable to checkout master branch"                                 >&2
	echo ""                                                                   >&2
	exit 1
fi

if [[ "${verbose}" == "1" ]] ; then
	echo ""                                                                   >&2
	git branch                                                                >&2
	echo ""                                                                   >&2
fi


#===============================================================================
#_______________________________________________________________________________
# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
#* - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - */
#* _________________________________________________________________________ */
#* vi config follows: */

#* ~/.exrc must contain "set modelines" for tabs to be set automatically */
#* ex:set tabstop=3 shiftwidth=3 sts=3: */ 

--------------000008030500080102060209
Content-Type: text/plain; name="diff_stable_patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment; filename="diff_stable_patch"

#! /bin/bash

# creating a broken out RT patch set


#-----  process script arguments

diff_patches=0
diff_series=0
save_diff=0
verbose=0

old_argc=0
while [[ ($# != ${old_argc}) && ($# > 0) ]] ; do
	old_argc=$#
	case $1 in
		-h | -help | --help )
			shift $# ;;
		--patches )
			diff_patches=1
			shift 1;;
		--sd )
			save_diff=1
			diff_file=$2
			shift 2;;
		--series )
			diff_series=1
			shift 1;;
		-v | --verbose )
			verbose=1
			shift ;;
	esac
done

if (( ($# < 1) || ($# > 2) )) ; then
	echo ""                                                                   >&2
	echo "usage: `basename $0` OLD_RT_KERNEL_VERSION NEW_RT_KERNEL_VERSION"   >&2
	echo "            -h         print this usage text"                       >&2
	echo "            -help      synonym for -h"                              >&2
	echo "           --help      synonym for -h"                              >&2
	echo "           --sd FILE   save diff file as FILE"                      >&2
	echo "            -v         verbose output"                              >&2
	echo "            -verbose   synonym for -v"                              >&2
	echo "           --verbose   synonym for -v"                              >&2
	echo ""                                                                   >&2
	echo "   examples:"                                                       >&2
	echo "       compare 3.0.12-rt29 to 3.0.32-rt52"                          >&2
	echo "          `basename $0` 3.0.12-rt29 3.0.32-rt52"                    >&2
	echo ""                                                                   >&2
	echo "   notes:"                                                          >&2
	echo ""                                                                   >&2
	echo "     --patches does not show changes to the series file,"           >&2
	echo "               contents of deleted patches, and contents"           >&2
	echo "               of added patches"                                    >&2
	echo ""                                                                   >&2
	exit 1
fi



# Choose the versions to be compared

#old_rt_version=3.0.12-rt29
#new_rt_version=3.0.23-rt38


old_rt_version=$1
old_patch_dir=patches_${old_rt_version}

new_rt_version=$2
new_patch_dir=patches_${new_rt_version}


#-----  error checks

if [[ ! -d ${old_patch_dir} ]] ; then
	echo ""                                                                   >&2
	echo "ERROR:"                                                             >&2
	echo "  Root patch directory ${old_patch_dir} does not exist"             >&2
	echo ""                                                                   >&2
	exit 1
fi


if [[ ! -d ${new_patch_dir} ]] ; then
	echo ""                                                                   >&2
	echo "ERROR:"                                                             >&2
	echo "  Root patch directory ${new_patch_dir} does not exist"             >&2
	echo ""                                                                   >&2
	exit 1
fi

if [[ "${diff_patches}" == "0" && "${diff_series}" == "0" ]] ; then
	echo ""                                                                   >&2
	echo "ERROR:"                                                             >&2
	echo "  no type of diff specified"                                        >&2
	echo ""                                                                   >&2
	exit 1
fi


#-----  patches added or deleted

# two different ways to see the same info, comment out the second way

if [[ "${diff_series}" == "1" ]] ; then

	echo

	diff -u {${old_patch_dir},${new_patch_dir}}/series \
		| grep -v "^--- " \
		| grep -v "^\+\+\+ " \
		| grep "^[-]" \
		| sort

	echo

	diff -u {${old_patch_dir},${new_patch_dir}}/series \
		| grep -v "^--- " \
		| grep -v "^\+\+\+ " \
		| grep "^[+]" \
		| sort

#	echo
#	echo
#
#	cat ${diff_file} | grep "^Only in ${old_patch_dir}" | sort
#
#	echo
#
#	cat ${diff_file} | grep "^Only in ${new_patch_dir}" | sort

	echo

fi


#-----  Changes to patch files

if [[ "${diff_patches}" == "1" ]] ; then

	if [[ "${save_diff}" == "1" ]] ; then

		if [[ "${diff_file}" == "" ]] ; then
			echo ""                                                             >&2
			echo "ERROR:"                                                       >&2
			echo "  -sd FILE name is blank"                                     >&2
			echo ""                                                             >&2
			exit 1
		fi

		if [[ -a ${diff_file} ]] ; then
			echo ""                                                             >&2
			echo "ERROR:"                                                       >&2
			echo "  ${diff_file} already exists"                                >&2
			echo ""                                                             >&2
			exit 1
		fi

	else
		diff_file=`mktemp`
	fi

	diff -x series -ru ${old_patch_dir}/ ${new_patch_dir}/ > ${diff_file}


	# (the files which are listed, but contain no # + or - lines are due to
	# changed commit IDs and Subject lines from rebasing)
	#
	# Changes that are "^[+-][+-]" are changes to the patch.
	#
	# Changes that are "^[+-] "    are changes of context.

	cat ${diff_file} \
		| grep -v "^[+-]From " \
		| grep -v "^[+-]Subject: "  \
		| grep -v "^--- ${old_patch_dir}" \
		| grep -v "^+++ ${new_patch_dir}" \
		| grep -E "(^diff |^[+-])" \
		| grep -v  "^[+-]index " \
		| grep -v  "^[+-]@@ "


	#-----  clean up

	if [[ "${save_diff}" == "0" ]] ; then
		rm ${diff_file}
	fi

fi

#===============================================================================
#_______________________________________________________________________________
# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
#* - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - */
#* _________________________________________________________________________ */
#* vi config follows: */

#* ~/.exrc must contain "set modelines" for tabs to be set automatically */
#* ex:set tabstop=3 shiftwidth=3 sts=3: */ 

--------------000008030500080102060209--
